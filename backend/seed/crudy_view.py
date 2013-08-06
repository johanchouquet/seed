import json

from django.conf.urls import patterns, url
from django.utils.decorators import method_decorator
from django.http import Http404, HttpResponse
from django.shortcuts import render

def view_decorator(function_decorator):
    """Convert a function based decorator into a class based decorator usable
    on class based Views.

    Can't subclass the `View` as it breaks inheritance (super in particular),
    so we monkey-patch instead.
    """
    def simple_decorator(View):
        View.validate = method_decorator(function_decorator)(View.validate)
        return View

    return simple_decorator

class _json_encoder(json.encoder.JSONEncoder):
    def default(self, o):
        if hasattr(o, '__json__'):
            return o.__json__()
        else:
            return o

class RestfulView(object):
    allowed = ['post', 'get', 'delete', 'put']

    def _router(self, request, *args, **kwargs):
        # Determine what type of request and route appropriately.
        # Browsers can only send AJAX request as GET or POST, so to emulate
        # PUT/DELETE requests etc we have to send this in the below header to
        # override the actual request method
        method = request.META.get('HTTP_X_HTTP_METHOD_OVERRIDE', request.method)
        if '_method' in request.POST:
            method = request.POST['_method']
        method = method.lower()

        # Convenience method for getting request variables
        self.request = request
        self.method = method
        self.params = self.get_params()

        if method in self.allowed and hasattr(self, method):
            validate_result = self.validate(request, *args, **kwargs)
            if validate_result:
                return validate_result
            return self.dispatch(request, *args, **kwargs)
        else:
            raise self.http404

    def validate(self, request, *args, **kwargs):
        pass

    def dispatch(self, request, *args, **kwargs):
        return getattr(self, self.method)(request, *args, **kwargs)

    @classmethod
    def as_view(cls):
        def view(request, *args, **kwargs):
            instance = cls()
            return instance._router(request, *args, **kwargs)
        view.__module__ = cls.__module__
        view.func_name = cls.__name__
        return view


    @classmethod
    def make_url_patterns(cls, url_root, url_name=None):
        view = cls.as_view()
        return patterns('',
            url(r'^%s/(?P<id>\w+)/(?P<method>[\w-]+)/?' % url_root, view),
            url(r'^%s/(?P<id>\w+)/?' % url_root, view),
            url(r'^%s/?' % url_root, view, name=url_name),
        )

    def render(self, template, context=None):
        return render(self.request, template, context)

    def _to_json(self, json_dict):
        json_string = json.dumps(json_dict, cls=_json_encoder)
        json_string = json_string.replace('<', '\\u003c')
        json_string = json_string.replace('>', '\\u003e')
        return json_string

    def json(self, json_dict={}):
        response = self._to_json(json_dict)
        response = HttpResponse(response, mimetype="application/json")
        return response

    def json_success(self, data=None):
        return self.json(data)

    def json_failure(self, error, status_code=500):
        response = self.json(error)
        response.status_code = status_code
        return response

    def get_params(self):
        if self.method == 'get':
            params = self.request.GET.dict()
        elif self.request.META.get('CONTENT_TYPE', '').startswith('application/json'):
            params = json.loads(self.request.body)
        else:
            params = self.request.POST.dict()
        return params

    @property
    def http404(self):
        return Http404

class CrudyView(RestfulView):
    def get(self, request, id=None, *args, **kwargs):
        if id:
            return self.read(request, id)
        else:
            return self.list(request)

    def post(self, request, id=None, method=None, *args, **kwargs):
        if method:
            print method
            method = method.replace('-', '_')

            return getattr(self, method)(request, id, *args, **kwargs)
        else:
            return self.create(request)

    def put(self, request, id, *args, **kwargs):
        return self.update(request, id)

    def delete(self, request, id, *args, **kwargs):
        return self.destroy(request, id)
