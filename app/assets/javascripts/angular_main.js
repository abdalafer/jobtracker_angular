
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

//Controllers
jobtracker.controller('HomeController', ['$route', '$scope', '$http', '$location', '$routeParams',
    function($route, $scope, $http, $location, $routeParams){
        //vm accessible via scope using controllerAs, bindToController:true
        var vm = this;

        $scope.$on('$locationChangeStart',function(evt, currentUrl, previousUrl) {
            //if current url is root then dont set canGoBack = false so back button directive does not go back.
            if (currentUrl.endsWith('#!/')){
                vm.canGoBack = false;
            } else {
                vm.canGoBack = true;
            }
        });

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
                    $scope.pending_tasks = result.data.tasks.created;
                    $scope.started_tasks = result.data.tasks.started;
                    $scope.finished_tasks = result.data.tasks.finished;
                })

            //if reloaded, load with preselected tab. previously stored at a task method
            var tab_selection = localStorage.getItem("task_tab_selection");

            if (tab_selection != null){
                $('.nav-tabs>li>a[data-target='+tab_selection+']').tab('show');
                localStorage.setItem("task_tab_selection", null);
            }
        }

        $scope.getJobTask = function(uuid){
            $http.get('/a_task/'+ uuid)
                .then(function (result){
                    console.log('.then(function (result){ Called')

                    $scope.job_task_detail = result.data;
                    $scope.job_task_detail = result.data;

                    $('#jobTaskDetailsModal').modal('show');
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
                    $("#newCustomerJobModal").on('hidden.bs.modal', function(){
                        $route.reload();
                    });
                })

        }

        $scope.addJobTask = function(){
            $scope.job_task.job_uuid = $scope.job.uuid

            $http.post('/a_add_job_task', {job_task: $scope.job_task})
                .then(function(result){
                    $('#newJobTaskModal').modal('hide');
                    $('#newJobTaskModal').on('hidden.bs.modal', function(){
                        $route.reload();
                    })

                })
        }

        $scope.startJobTask = function(uuid){
            $http.post('/a_task/'+uuid+'/start')
                .then(function(){
                    //todo eventually update just the current panel not the whole route
                    $route.reload();
                })
        }

        $scope.finishJobTask = function(uuid){
            $http.post('/a_task/'+uuid+'/finish')
                .then(function(){
                    //todo eventually update just the current panel not the whole route
                    $route.reload();

                    localStorage.setItem("task_tab_selection", $('.nav-tabs .active > a').attr('data-target') );
                })
        }

        $scope.deleteJobTask = function(uuid){
            $http.delete('/a_task/'+uuid)
                .then(function(){
                    $route.reload();

                    localStorage.setItem("task_tab_selection", $('.nav-tabs .active > a').attr('data-target') );
                })
        }
    }
])

//Directives
//back button
//todo, hide when at Home "/"
jobtracker.directive("angularBack", ['$window', function($window){
    return {
        template: "<button class='btn btn-primary'>Back</button>",
        controller: 'HomeController',
        controllerAs: 'vm',
        bindToController:true,
        link: function(scope, elem, attrs){
            elem.bind('click', function(){
                //todo, back button should not refresh page. instead load previous route
                if (scope.vm.canGoBack){
                    javascript:history.go(-1)
                }

            })
        }
    };
}]);

jobtracker.directive("taskDetailView", [function($compile){
    return {
        templateUrl: '_task_details.html'
    }

}])

