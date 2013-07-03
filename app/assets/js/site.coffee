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
                        $scope.searchData = []
                        $scope.searchDataCopy = data
                        console.log data
                ).error(
                    ->
                )
            
            $scope.showSearch = null
            $scope.showOrderPanel = null
            
            $scope.startOrder = ->
                
                $.get(
                        "/order/init"

                    ).success(

                        (order) ->

                            $scope.order = order

                    ).error(

                        ->
                    )

                $.get(

                    "/client/list"

                ).success( 
                    (data) ->
                        $scope.clientList = data
                        $scope.$apply()
                ).error(
                    (err) ->
                        console.log err
                )

                $scope.showSearch = 'true'
                $scope.showOrderPanel = 'true'
                $scope.orderItems = []

            $scope.addItem = (item) ->

                OrderItem = {product: 0, unit: "", count: 0, name: "", price: 0}

                console.log "Adding Item"

                for i in $scope.searchData

                    if i.material_num == item

                        OrderItem.product = i.material_num
                        OrderItem.unit = $scope.unit_select
                        OrderItem.count = $scope.unit_count
                        OrderItem.name = i.description

                        switch OrderItem.unit
                            when 'pallete'
                                OrderItem.price = i.pallete_cost * OrderItem.count
                            when 'case'
                                OrderItem.price = i.case_cost * OrderItem.count
                            when 'pack'
                                OrderItem.price = i.pack_cost * OrderItem.count

                        $scope.orderItems.push OrderItem

                        break

                $scope.totalCost = 0

                for c in $scope.orderItems
                    $scope.totalCost = $scope.totalCost + c.price
                $scope.order.items.push OrderItem

            $scope.$watch "query", (value)  ->

                if value?
                    if value.length < 3

                        $scope.searchData = []

                    else

                        $.get(

                            "/products/search/" + value

                        ).success( 
                            (data) ->
                                $scope.searchData = data
                                $scope.$apply()
                        ).error(
                            (err) ->
                                console.log err
                        )

            $scope.$watch "unitTypeSelect", (value)  ->

                if value?

                    $scope.unit_select = value

                    console.log value

            $scope.$watch "unitCount", (value)  ->

                if value?

                    $scope.unit_count = value

                    console.log value

            $scope.setItemNumber = (value) ->

                $scope.itemNumber = value
                
                console.log value

