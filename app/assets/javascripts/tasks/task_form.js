app = angular.module('TodoList');

app.directive('taskForm', function(){
  return {
    scope:{
      project: '=',
      flash: "="
    },
    templateUrl: 'tasks/_task_form.html',
    controller: ['$scope', 'projects', function($scope, projects){
      $scope.addTask = function(){
        if(!$scope.title || $scope.title === '') { 
          $scope.flash.setFlash(['alert', 'Task title cannot be empty'])
          return; 
        }
        
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
