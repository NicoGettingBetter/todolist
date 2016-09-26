app = angular.module('TodoList');

app.directive('commentItem', function(){
  return {
    replace: true,
    scope: {
      comment: '='
    },
    templateUrl: 'comments/_comment.html',
    controller: ['$scope', 'projects', function($scope, projects){
      $scope.removeComment = function(){
        projects.removeComment($scope.comment);
      }

      $scope.updateComment = function(){
        if(!$scope.comment.text || $scope.comment.text === '') { 
          $scope.flash.setFlash(['alert', 'Comment cannot be empty']);
          return; 
        }
        
        projects.updateComment($scope.comment);
      }
    }],
    link: function($scope){
      $scope.$watch('comment.text', function(comment){
        $scope.updateComment();
      })
    }
  }
});
