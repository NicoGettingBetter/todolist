app = angular.module('TodoList');

app.directive('projectForm', function(){
  return {
    scope: {
      flash: '='
    },
    templateUrl: 'projects/_project_form.html',
    controller: ['$scope', 'projects', function($scope, projects){
      $scope.addProject = function(){
        if(!$scope.title || $scope.title === '') { 
          $scope.flash.setFlash(['alert', 'Project title cannot be empty']);
          return; 
        }
        
        projects.create({
          title: $scope.title
        });

        $scope.title = '';
      };
    }]
  }
});
