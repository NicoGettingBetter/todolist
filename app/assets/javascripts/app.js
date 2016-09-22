app = angular.module('TodoList', [
  'ui.router',
  'templates',
  'ng-rails-csrf'
]);

app.config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {
  $urlRouterProvider.otherwise('/');

  $stateProvider
    .state('home', {
      url: '/',
      template: '<todo-list-container></todo-list-container>',
      resolve: {
        projectPromise: ['projects', function(projects){
          return projects.getAll();
        }]
      }
    })
}]);
