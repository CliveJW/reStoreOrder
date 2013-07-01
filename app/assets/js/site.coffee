#= require vendor/jquery.js
#= require vendor/bootstrap.js
#= require_tree shared


$ -> 

        angularModule = angular.module 'reStoreOrder', []

        angularModule.controller 'ListController', ($scope) -> 


        angularModule.controller 'OrderController', ($scope) -> 
            $.get(

                    "/products/search/"

                ).success( 
                    (data) ->
                        $scope.searchData = data
                ).error(
                    ->
                )
            
            $scope.showSearch = null
            $scope.showOrderPanel = null
            
            $scope.startOrder = ->
                $.get(
                        "/order/init"
                    ).success(
                        (data) ->
                            console.log data
                    ).error(
                        ->
                    )

                $scope.showSearch = 'true'
                $scope.showOrderPanel = 'true'

            $scope.addItem = (item) ->
                console.log "Adding Item"
                console.log item
