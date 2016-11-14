app = angular.module('TodoList');

app.directive('commentForm', function(){
  return {
    scope:{
      task: '=',
      flash: '='
    },
    templateUrl: 'comments/_comment_form.html',
    controller: ['$scope', 'projects', function($scope, projects){
      $scope.addComment = function(){
        if(!$scope.text || $scope.text === '') { 
          $scope.flash.setFlash(['alert', 'Comment cannot be empty']);
          return; 
        }
        projects.addComment({
          text: $scope.text,
          task_id: $scope.task.id,
          file: $scope.file
        }).success(function(data){
          data.file_attachments = [];
          if ($scope.task.comments)
            $scope.task.comments.push(data);
          else
            $scope.task.comments = [data];
        });

        $scope.text = '';
      };
    }]
  }
});