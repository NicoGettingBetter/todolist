app = angular.module('TodoList');

app.directive('commentItem', function(){
  return {
    replace: true,
    scope: {
      comment: '=',
      flash: '='
    },
    templateUrl: 'comments/_comment.html',
    controller: ['$scope', 'projects', 'Upload', '$timeout', 
      function($scope, projects, Upload, $timeout){

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

      $scope.uploadFiles = function(files, errFiles) {
        $scope.files = files;
        $scope.errFiles = errFiles;
        
        angular.forEach(files, function(file) {
          var task;
          projects.projects.find(function(project){
            return task = project.tasks.find(function(task){
              return $scope.comment.task_id === task.id;
            });
          });

          file.upload = Upload.upload({
            url: '/projects/' + task.project_id + '/tasks/' + task.id + '/comments/' + $scope.comment.id 
        + '/file_attachments.json',
            file: { url: file, comment_id: $scope.comment.id }
          });

          file.upload.then(function (response) {
            projects.addFile(response.data);
            $scope.flash.setFlash(['notice', 'File uploaded']);
            $timeout(function () {
              file.result = response.data;
            });
          }, function (response) {
            if (response.status > 0)
              $scope.flash.setFlash(['alert', response.status + ': ' + response.data]);
          }, function (evt) {
            var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
            file.progress = Math.min(100, parseInt(100.0 * evt.loaded / evt.total));
          });
        });
      };
    }],
    link: function($scope){
      $scope.$watch('comment.text', function(comment){
        $scope.updateComment();
      })
    }
  }
});
