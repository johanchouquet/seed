define([
    'backbone',
    'underscore'
],
function(Backbone, _){

var EmailView = Backbone.View.extend({

    // Properties
    el: null,
    template: null,

    events: {
        'click button.back': 'backToList'
    },

    backToList: function (event) {
    },

    render: function(data){
        data = data || {};
        var compiled = _.template(this.template),
            html = compiled({email: data});
        this.$el.html(html);
    }

});

return EmailView;

});
