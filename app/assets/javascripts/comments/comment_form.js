app = angular.module('TodoList');

app.directive('commentForm', function(){
  return {
    scope:{
      task: '='
    },
    templateUrl: 'comments/_comment_form.html',
    controller: ['$scope', 'projects', function($scope, projects){
      $scope.addComment = function(){
        if(!$scope.text || $scope.text === '') { return; }
        projects.addComment({
          text: $scope.text,
          task_id: $scope.task.id,
          file: $scope.file
        }).success(function(data){
          $scope.task.comments.push(data);
        });

        $scope.text = '';
      };
    }]
  }
});