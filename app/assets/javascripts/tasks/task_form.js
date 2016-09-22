app = angular.module('TodoList');

app.directive('taskForm', function(){
  return {
    scope:{
      project: '='
    },
    templateUrl: 'tasks/_task_form.html',
    controller: ['$scope', 'projects', function($scope, projects){
      $scope.addTask = function(){
        if(!$scope.title || $scope.title === '') { return; }
        projects.addTask({
          title: $scope.title,
          project_id: $scope.project.id,
          priority: 1
        }).success(function(data){
          $scope.project.tasks.push(data);
        });

        $scope.title = '';
      };
    }]
  }
});
