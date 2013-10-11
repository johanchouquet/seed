define([
    'backbone',
    'underscore'
],
function(Backbone, _){

var EmailPreviewView = Backbone.View.extend({

    // Properties
    el: null,
    template: null,

    render: function(){
        var compiled = _.template(this.template),
            html = compiled();
        this.$el.html(html);
    }

});

return EmailPreviewView;

});
