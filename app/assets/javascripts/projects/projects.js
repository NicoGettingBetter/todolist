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

  object.update = function(project) {
    return $http.put('/projects/' + project.id + '.json', project)
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

  object.updateTask = function(task) {
    return $http.put('/projects/' + task.project_id + '/tasks/' + task.id + '.json', task);
  };

  object.addComment = function(comment) {
    var task;
    object.projects.find(function(project){
      return task = project.tasks.find(function(task){
        return comment.task_id === task.id;
      });
    });
    return $http.post('/projects/' + task.project_id + '/tasks/' + task.id + '/comments.json', comment);
  }

  object.removeComment = function(comment) {
    var task;
    object.projects.find(function(project){
      return task = project.tasks.find(function(task){
        return comment.task_id === task.id;
      });
    });
    var comment_i = task.comments.indexOf(comment);
    return $http.delete('/projects/' + task.project_id + '/tasks/' + task.id + '/comments/' + comment.id 
      + '.json').success(function(){
        task.comments.splice(comment_i, 1);
      });
  }

  object.updateComment = function(comment) {
    var task;
    object.projects.find(function(project){
      return task = project.tasks.find(function(task){
        return comment.task_id === task.id;
      });
    });
    return $http.put('/projects/' + task.project_id + '/tasks/' + task.id + '/comments/' + comment.id 
      + '.json', comment);
  }

  return object;
}]);
