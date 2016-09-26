app = angular.module('TodoList');

app.controller('AuthCtrl', ['$scope', '$state', 'Auth', 'FlashMessage', 
  function($scope, $state, Auth, FlashMessage){
  $scope.login = function() {
    Auth.login($scope.user).then(function(){
      FlashMessage.setFlash(["notice", "You have logged in"]);
      $state.go('home');
    }, function(error){      
      FlashMessage.setFlash(["alert", error.data.error ]);
    });
  };

  $scope.register = function() {
    Auth.register($scope.user).then(function(){
      FlashMessage.setFlash(["notice", "You have registered"]);
      $state.go('home');
    }, function(error){      
      FlashMessage.setFlash(["alert", error.data.error ]);
    });
  };
}]);