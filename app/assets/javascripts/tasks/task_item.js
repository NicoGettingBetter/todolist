app = angular.module('TodoList');

app.directive('taskItem', function(){
  return {
    replace: true,
    scope: {
      task: '='
    },
    templateUrl: 'tasks/_task.html',
    controller: ['$scope', 'projects', function($scope, projects){
      $scope.priorities = ["urgent", "high", "medium", "low"];
      $scope.task.hideComments = true;

      $scope.removeTask = function(){
        projects.removeTask($scope.task);
      }

      $scope.updateTask = function(){
        projects.updateTask($scope.task);
      }

      $scope.toggleComments = function(){
        $scope.task.hideComments = !$scope.task.hideComments;
      }

      $scope.higher = function(){
        if ($scope.task.priority > 0) {
          $scope.task.priority -= 1;
        }
      }

      $scope.lower = function(){
        if ($scope.task.priority < 3) {
          $scope.task.priority += 1;
        }
      }
    }],
    link: function($scope){
      $scope.$watch('task', function(task){
        $scope.updateTask();
      }, true);
    }
  }
});
