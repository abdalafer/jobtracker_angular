
var jobtracker = angular.module('jobtracker', ['templates', 'ngRoute' ]);

//Routes
jobtracker.config(['$routeProvider',
    function($routeProvider){
        $routeProvider
            .when('/', {
                templateUrl: 'customers.html',
                controller: 'HomeController'
            })
            .when('/a_customer/:id/jobs', {
                templateUrl: 'customer_jobs.html',
                controller: 'HomeController'
            })
            .when('/a_job/:id/tasks', {
                templateUrl: 'job_tasks.html',
                controller: 'HomeController'
            })
}]);

//back button
//todo, hide when at Home "/"
jobtracker.directive("angularBack", [function($window){
    return {
        template: "<button class='btn btn-primary'>Back</button>",
        link: function(scope, elem, attrs){
            elem.bind('click', function(){
                //todo, back button should not refresh page. instead load previous route
                javascript:history.go(-1)
            })
        }
    };
}]);

//Controllers
jobtracker.controller('HomeController', ['$route', '$scope', '$http', '$location', '$routeParams',
    function($route, $scope, $http, $location, $routeParams){
        $scope.getCustomers = function(){
            $http.get('/a_customers_data')
                .then(function (result){
                    $scope.customers = result.data;
                })
        }

        $scope.getCustomerJobs = function(){
            uuid = $routeParams.id;
            $http.get('/a_customer_data/'+ uuid+'/jobs')
                .then(function (result){
                    $scope.customer = result.data.customer;
                    $scope.jobs = result.data.jobs;

                })
        }

        $scope.getJobTasks = function(){
            uuid = $routeParams.id;
            $http.get('/a_job/'+ uuid+'/tasks')
                .then(function (result){
                    $scope.job = result.data.job;
                    $scope.pending_tasks = result.data.created;
                    $scope.started_tasks = result.data.started;
                    $scope.finished_tasks = result.data.finished;
                })
        }

        $scope.addCustomer = function(){
            $http.post('/a_add_customer', {customer: $scope.customer})
                .then(function (result){
                    window.location.href='/'
                })
        }

        $scope.addJob = function(){
            $scope.job.customer_uuid = $scope.customer.uuid

            $http.post('/add_customer_job', {job: $scope.job})
                .then(function(result){
                    //$route.reload() modal does not close, should use bootstrap angular ui
                    $('#newCustomerJobModal').modal('hide');
                    $("#newCustomerJobModal").on('hidden.bs.modal', function () {
                        $route.reload();
                    });
                })

        }
    }
])
