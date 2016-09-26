app = angular.module('TodoList');

app.controller("AppController", ['$scope', '$state', 'Auth', 'projects', 'FlashMessage',
  function($scope, $state, Auth, projects, FlashMessage){
  if (!Auth.isAuthenticated())
    $state.go('login');

  $scope.flash = FlashMessage;
  $scope.projects = projects.projects;
}]);
