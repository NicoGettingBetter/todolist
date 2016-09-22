app = angular.module('TodoList');

app.controller("AppController", ['$scope', 'projects', function($scope, projects){
  $scope.projects = projects.projects;
}]);
