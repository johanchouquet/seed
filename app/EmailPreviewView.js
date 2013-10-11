define([
    'jquery',
    'backbone',
    'underscore'
],
function(jQuery, Backbone, _){

var EmailPreviewView = Backbone.View.extend({

    // Properties
    el: null,
    template: null,

    events: {
        'click .email': 'emailClicked'
    },

    emailClicked: function (event) {
        var el = jQuery(event.currentTarget);
            emailId = el.attr('data-id');
        console.log('show', emailId);
        return emailId;
    },

    render: function(data){
        data = data || {};
        var compiled = _.template(this.template),
            html = compiled({data: data});
        this.$el.html(html);
    }

});

return EmailPreviewView;

});
