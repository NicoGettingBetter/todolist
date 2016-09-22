app = angular.module('TodoList');

app.factory('projects', ['$http', function($http){
  var object = {
    projects: []
  };

  object.getAll = function() {
    return $http.get('/projects.json').success(function(data){
      angular.copy(data, object.projects);
    });
  };

  object.create = function(project) {
    return $http.post('/projects.json', project).success(function(data){
      object.projects.push(data);
    });
  };

  object.remove = function(project) {
    var i = object.projects.indexOf(project);
    return $http.delete('/projects/' + project.id + '.json').success(function(){
      object.projects.splice(i, 1);
    })
  }

  object.addTask = function(task) {
    return $http.post('/projects/' + task.project_id + '/tasks.json', task);
  };

  object.removeTask = function(task) {
    var project = object.projects.find(function(project){
      return project.id === task.project_id;
    });
    var task_i = project.tasks.indexOf(task);
    return $http.delete('/projects/' + task.project_id + '/tasks/' + task.id + '.json').success(function(){
      project.tasks.splice(task_i, 1);
    });
  };

  return object;
}]);
