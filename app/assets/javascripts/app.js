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
    //.state('about', {
    //  abstract: true,
    //  url: '/about',
    //  templateUrl: 'tas/about.html'
    //})
    //.state('about.index', {
    //  url: '/',
    //  template: '<h1>Hello world</h1>'
    //})
    //.state('about.team', {
    //  url: '/team',
    //  template: '<h1>This is our team</h1>'
    //})
    //.state('about.portfolio', {
    //  url: '/portfolio',
    //  template: '<ul><li>Porject 1</li><li>Porject 2</li><li>Porject 3</li></ul>'
    //})
    //.state('not_found', {
    //  url: '/not_found?error',
    //  template: 'ERROR! {{ error }}',
    //  controller: ['$stateParams', '$scope', function($stateParams, $scope) {
    //    $scope.error = $stateParams.error;
    //  }]
    //})
    //.state('todo', {
    //  url: '/todo/:id',
    //  template: '<todo-item item="todo"></todo-item><a ui-sref="home">Home</a>',
    //  resolve: {
    //    data: ['$stateParams', '$state', function($stateParams, $state) {
    //      const id = _.parseInt($stateParams.id);
    //      return getItem(id);
    //    }]
    //  },
    //  controller: ['$scope', 'data', function($scope, data) {
    //    $scope.todo = data;
    //  }]
    //})
}]);
