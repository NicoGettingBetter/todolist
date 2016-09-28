app = angular.module('TodoList');

app.directive('fileItem', function(){
  return {
    replace: true,
    scope: {
      file: '='
    },
    templateUrl: 'files/_file.html',
    controller: ['$scope', 'projects', function($scope, projects){
      $scope.removeFile = function(){
        projects.removeFile($scope.file);
      }
    }]
  }
});
