app = angular.module('TodoList');

app.directive('projectForm', function(){
  return {
    templateUrl: 'projects/_project_form.html',
    controller: ['$scope', 'projects', function($scope, projects){
      $scope.addProject = function(){
        if(!$scope.title || $scope.title === '') { return; }
        projects.create({
          title: $scope.title
        });

        $scope.title = '';
      };
    }]
  }
});
