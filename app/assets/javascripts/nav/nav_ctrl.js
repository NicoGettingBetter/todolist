app = angular.module('TodoList');

app.directive('navCtrl', function(){
  return {
    templateUrl: 'nav/_nav.html',
    controller: ['$scope', '$state', '$auth', 'FlashMessage',
      function($scope, $state, $auth, FlashMessage){
      $scope.isAuthenticated = $auth.isAuthenticated();

      $scope.logout = function(){
        if (!$scope.isAuthenticated) 
          return;
        $auth.logout().then(function(){
          FlashMessage.setFlash(["notice", "You have logged out"]);
          $state.go('login');
        })
      }
    }]
}});