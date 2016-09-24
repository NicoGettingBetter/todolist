app = angular.module('TodoList');

app.directive('taskItem', function(){
  return {
    replace: true,
    scope: {
      task: '='
    },
    templateUrl: 'tasks/_task.html',
    controller: ['$scope', 'projects', '$filter', function($scope, projects, $filter){
      $scope.priorities = ["urgent", "high", "medium", "low"];
      $scope.task.hideComments = true;
      $scope.task.hideDate = true;
      $scope.date = $filter('date')($scope.task.deadline, 'MM/dd/yyyy');

      $scope.removeTask = function(){
        projects.removeTask($scope.task);
      }

      $scope.updateTask = function(){
        projects.updateTask($scope.task);
      }

      $scope.toggleComments = function(){
        $scope.task.hideComments = !$scope.task.hideComments;
      }

      $scope.toggleDate = function(){
        $scope.task.hideDate = !$scope.task.hideDate;
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

      $(document).ready(function(){
        $('.input-group.date').datepicker({
          format: "mm/dd/yyyy",
          startDate: "infinity",
          autoclose: true,
          todayHighlight: true
        });
      });
    }],
    link: function($scope){
      $scope.$watch('task', function(task){
        $scope.updateTask();
      }, true);

      $scope.$watch('date', function(date){
        $scope.task.deadline = new Date($scope.date);
      });
    }
  }
});
