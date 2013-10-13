define([
    'backbone',
    'underscore'
],
function(Backbone, _){

var EmailView = Backbone.View.extend({

    events: {
        'click button.back': 'backToList'
    },

    backToList: function (event) {
    },

    render: function(data){
        data = data || {};
        var compiled = _.template(this.template),
            html = compiled({data: data});
        this.$el.html(html);
    }

});

return EmailView;

});
