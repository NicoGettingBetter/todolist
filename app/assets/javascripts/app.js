app = angular.module('TodoList', [
  'ui.router',
  'templates',
  'ng-rails-csrf',
  'Devise',
  'ngFileUpload'
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
      },
      onEnter: ['$state', 'Auth', function($state, Auth) {
        if (!Auth.isAuthenticated())
          $state.go('login');
      }]
    })
    .state('login', {
      url: '/login',
      templateUrl: 'auth/_login.html',
      controller: 'AuthCtrl',
      onEnter: ['$state', 'Auth', function($state, Auth) {
        Auth.currentUser().then(function (){
          $state.go('home');
        })
      }]
    })
    .state('register', {
      url: '/register',
      templateUrl: 'auth/_register.html',
      controller: 'AuthCtrl',
      onEnter: ['$state', 'Auth', function($state, Auth) {
        Auth.currentUser().then(function (){
          $state.go('home');
        })
      }]
    })
}]);

app.config(['$httpProvider', function($httpProvider) {
    $httpProvider.defaults.withCredentials = true;
  }
]);
