app = angular.module('TodoList');

app.controller("AppController", ['$scope', '$state', 'Auth', 'projects', function($scope, $state, Auth, projects){
  if (!Auth.isAuthenticated())
    $state.go('login');

  $scope.projects = projects.projects;
}]);
