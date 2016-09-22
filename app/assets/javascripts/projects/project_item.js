app = angular.module('TodoList');

app.directive('projectItem', function(){
  return {
    replace: true,
    scope: {
      project: '='
    },
    templateUrl: 'projects/_project.html',
    controller: ['$scope', 'projects', function($scope, projects){
      $scope.removeProject = function(){
        projects.remove($scope.project);
      }
    }]
  }
});
