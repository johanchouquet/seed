define(['backbone'], function(Backbone) {

var EmailModel = Backbone.Model.extend({
    loadEmail: function(id) {
        this.set('id', id);
        return this.fetch();
    },
    url: function() {
        return this.urlRoot.replace(/\{id\}/, this.id);
    }
});

return EmailModel;

});
