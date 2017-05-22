app = angular.module('TodoList');

app.controller("AppController", ['$scope', '$state', 'projects', 'FlashMessage', '$auth',
  function($scope, $state, projects, FlashMessage, $auth){
  if (!$auth.isAuthenticated())
    $state.go('login');

  $scope.flash = FlashMessage;
  $scope.projects = projects.projects;
}]);
