app = angular.module('TodoList');

app.directive('taskItem', function(){
  return {
    replace: true,
    scope: {
      task: '='
    },
    templateUrl: 'tasks/_task.html',
    controller: ['$scope', 'projects', function($scope, projects){
      $scope.removeTask = function(){
        projects.removeTask($scope.task);
      }
    }]
  }
});
