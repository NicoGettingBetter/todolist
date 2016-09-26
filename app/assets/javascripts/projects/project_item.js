app = angular.module('TodoList');

app.directive('projectItem', function(){
  return {
    replace: true,
    scope: {
      project: '=',
      flash: '='
    },
    templateUrl: 'projects/_project.html',
    controller: ['$scope', 'projects', function($scope, projects){
      $scope.removeProject = function(){
        projects.remove($scope.project);
      }

      $scope.updateProject = function(){
        if(!$scope.project.title || $scope.project.title === '') { 
          $scope.flash.setFlash(['alert', 'Project title cannot be empty']);
          return; 
        }
        
        projects.update($scope.project);
      }
    }],
    link: function($scope){
      $scope.$watch('project.title', function(){
        $scope.updateProject();
      })
    }
  }
});
