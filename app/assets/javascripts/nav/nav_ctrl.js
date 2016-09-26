app = angular.module('TodoList');

app.directive('navCtrl', function(){
  return {
    templateUrl: 'nav/_nav.html',
    controller: ['$scope', '$state', 'Auth', 'FlashMessage',
      function($scope, $state, Auth, FlashMessage){
      $scope.signedIn = Auth.isAuthenticated;
      $scope.logout = Auth.logout;
      $scope.flash = FlashMessage;
      
      Auth.currentUser().then(function (user){
        $scope.user = user;
      });

      $scope.$on('devise:new-registration', function (e, user){
        $scope.user = user;
      });

      $scope.$on('devise:login', function (e, user){
        $scope.user = user;
      });

      $scope.$on('devise:logout', function (e, user){
        $scope.user = {};
        $state.go('login');
        $scope.flash.setFlash(["notice", "You have logged out"]);
      });
    }]
}});