app = angular.module('TodoList');

app.directive('flashMessages', function(){
  return {
    scope: {
      flash: "="
    },
    templateUrl: 'flash/_flash_messages.html'
  }
})
