define([
    'backbone',
    'underscore'
],
function(Backbone, _){

var EmailPreviewView = Backbone.View.extend({

    // Properties
    el: null,
    template: null,

    render: function(data){
        data = data || {};
        var compiled = _.template(this.template),
            html = compiled({data: data});
        this.$el.html(html);
    }

});

return EmailPreviewView;

});
