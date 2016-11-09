app = angular.module('TodoList');

app.controller('AuthCtrl', ['$scope', '$state', 'FlashMessage', '$auth',
  function($scope, $state, FlashMessage, $auth){
  $scope.login = function() {
    $auth.login($scope.user).then(function(){
      FlashMessage.setFlash(["notice", "You have logged in"]);
      $state.go('home');
    }, function(error){ 
      console.log(error);     
      FlashMessage.setFlash(["alert", error.data.error ]);
    });
  };

  $scope.register = function() {
    $auth.signup($scope.user).then(function(response){
      FlashMessage.setFlash(["notice", "You have registered"]);
      $auth.setToken(response);
      $state.go('home');
    }, function(error){      
      FlashMessage.setFlash(["alert", error.data.error ]);
    });
  };

  $scope.authenticate = function(provider) {
    $auth.authenticate(provider).then(function(){
      if (!$auth.isAuthenticated()) {
        $('.facebook').click();
      }
      $state.go('home');
    });
  };
}]);