#= require vendor/jquery.js
#= require vendor/bootstrap.js
#= require_tree shared


$ -> 

        angularModule = angular.module 'reStoreOrder', []

        angularModule.controller 'ListController', ($scope) -> 


        angularModule.controller 'OrderController', ($scope) -> 
            $("#discountSet").val "0"
            console.log $("#discountSet").val
            $scope.showSearch = null
            $scope.showOrderPanel = null
            
            $scope.startOrder = ->
                
                $.get(
                        "/order/init"

                    ).success(

                        (order) ->
                            console.log order
                            order.order_id = order._id
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

                OrderItem = {product: 0, unit: "", count: 0, name: "", price: 0, discount: 0}

                for i in $scope.searchData

                    if i.material_num == item

                        OrderItem.product = i.material_num
                        OrderItem.unit = $scope.unit_select
                        OrderItem.count = $scope.unit_count
                        OrderItem.name = i.description

                        OrderItem.discount = $scope.discount
                        disMins = (OrderItem.discount / 100)
                        console.log disMins
                        switch OrderItem.unit
                            when 'pallete'
                                if OrderItem.discount > 0

                                    OrderItem.price = $scope.normalize((i.pallete_cost * OrderItem.count) - ((OrderItem.discount / 100) * (i.pallete_cost * OrderItem.count)))
                                else 
                                    OrderItem.price = $scope.normalize(i.pallete_cost * OrderItem.count)
                            when 'case'
                                if OrderItem.discount > 0
                                    OrderItem.price = $scope.normalize((i.case_cost * OrderItem.count) - ((OrderItem.discount / 100) * (i.case_cost * OrderItem.count)))
                                else 
                                    OrderItem.price = $scope.normalize(i.case_cost * OrderItem.count)
                            when 'pack'
                                if OrderItem.discount > 0
                                    OrderItem.price = $scope.normalize((i.pack_cost * OrderItem.count) - ((OrderItem.discount / 100) * (i.pack_cost * OrderItem.count)))
                                else 
                                    OrderItem.price = $scope.normalize(i.pack_cost * OrderItem.count)
                        

                        $scope.orderItems.push OrderItem

                        break

                $scope.totalCost = 0

                for c in $scope.orderItems
                    $scope.totalCost = $scope.totalCost + c.price
                $scope.order.items.push OrderItem
                console.log $scope.order

                $.post(
                    '/order/saveOrder', $scope.order
                ).success(
                    (data) ->
                ).error(
                    (err) ->
                )


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


            $scope.$watch "discountModel", (value)  ->

                if value?

                    $scope.discount = value

                    console.log value


            $scope.$watch "clients", (value)  ->

                if value?

                    $scope.clientName = value

                    console.log value
                    console.log 'meh'

            $scope.setItemNumber = (value) ->

                $scope.itemNumber = value

                $scope.discountModel = 0

                $scope.unitCount = 0

                console.log value

            $scope.dropOrder = ->

                $.get(

                    "/order/drop/" + $scope.clientName.name

                ).success( 
                    (data) ->
                        $scope.$apply()
                ).error(
                    (err) ->
                        console.log err
                )

            $scope.normalize = (num) ->
                return (Math.floor(( num )*100))/100

