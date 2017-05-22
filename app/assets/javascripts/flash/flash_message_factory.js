app = angular.module('TodoList');

app.factory('FlashMessage', function() {
  var object = {
    queue: []
  };

  object.setFlash = function(flash) {
    return object.queue.push(flash);
  };

  object.deleteFlash = function(flash) {
    var i = object.queue.indexOf(flash);
    return object.queue.splice(i, 1);
  };

  return object;
});