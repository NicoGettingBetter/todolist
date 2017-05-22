app = angular.module('TodoList', [
  'ui.router',
  'templates',
  'ng-rails-csrf',
  'ngFileUpload',
  'satellizer'
]);

app.config(['$stateProvider', '$urlRouterProvider', '$authProvider', 
  function($stateProvider, $urlRouterProvider, $authProvider) {
  $urlRouterProvider.otherwise('/');

  $authProvider.loginUrl = '/auth/login';
  $authProvider.signupUrl = '/auth/signup';

  $authProvider.facebook({
    clientId: '689899577825670'
  });

  $stateProvider
    .state('home', {
      url: '/',
      template: '<todo-list-container></todo-list-container>',
      resolve: {
        projectPromise: ['projects', function(projects){
          return projects.getAll();
        }]
      },
      onEnter: ['$state', '$auth', function($state, $auth) {
        if (!$auth.isAuthenticated())
          $state.go('login');
      }]
    })
    .state('login', {
      url: '/login',
      templateUrl: 'auth/_login.html',
      controller: 'AuthCtrl',
      onEnter: ['$state', '$auth', function($state, $auth) {
        if ($auth.isAuthenticated())
          $state.go('home');
      }]
    })
    .state('register', {
      url: '/register',
      templateUrl: 'auth/_register.html',
      controller: 'AuthCtrl',
      onEnter: ['$state', '$auth', function($state, $auth) {
        if ($auth.isAuthenticated())
          $state.go('home');
      }]
    })
}]);
