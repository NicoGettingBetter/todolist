app = angular.module('TodoList');

app.directive('todoListContainer', function(){
  return {
    scope: true,
    controllerAs: 'ctrl',
    bindToController: true,
    templateUrl: 'todo_list_container/_todo_list_container.html'
  }
});
