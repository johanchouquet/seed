from django.shortcuts import render
from seed.crudy_view import CrudyView

def home(request):
    return render(request, "index.html")


class MessageView(CrudyView):

    def list(self, request):
        return self.json_success([{
            "feck": "arse",
            "id:": 1232343
        },{
            "feck": "balls",
            "id": 865343
        }])

    def read(self, request, id):
        return self.json_success({
            "feck": "arse",
            "id": id
        })

    def archive(self, request, id):
        return self.json_success({
            "status": "archived",
            "feck": "arse",
            "id": id
        })

