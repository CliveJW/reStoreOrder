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
                            $scope.order = order
                            order.order_id = order._id
                            $scope.order_num = order.order_num
                            $scope.$apply()

                    ).error(

                        (err) ->
                    )

                $.get(

                    "/client/list"

                ).success( 
                    (data) ->
                        $scope.clientList = data
                        $scope.showSearch = 'true'
                        $scope.showOrderPanel = 'true'
                        $scope.orderItems = []
                        $scope.$apply()
                ).error(
                    (err) ->
                        console.log err
                )




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
                    $scope.totalCost = $scope.normalize($scope.totalCost + c.price)
                $scope.order.items.push OrderItem
                $scope.order.total = $scope.totalCost
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
                    $scope.order.client = value
                    console.log value
                    console.log 'meh'

            $scope.setItemNumber = (value) ->

                $scope.itemNumber = value

                $scope.discountModel = 0

                $scope.unitCount = 0

                console.log value

            $scope.dropOrder = ->

                $.post(

                    "/order/drop", $scope.order

                ).success( 
                    (data) ->
                        $scope.$apply()
                ).error(
                    (err) ->
                        console.log err
                )

            $scope.normalize = (num) ->
                return (Math.floor(( num )*100))/100


        angularModule.controller 'PrevOrderController', ($scope) -> 

            $.get(

                    "/client/list"

                ).success( 
                    (data) ->
                        $scope.clientList = data
                        $scope.showSearch = 'true'
                        $scope.showOrderPanel = 'true'
                        $scope.orderItems = []
                        $scope.$apply()
                        console.log data
                ).error(
                    (err) ->
                        console.log err
                )

            $scope.$watch "prevAcc", (value)  ->
                if value?
                    $.get(
                        "/client/orders/" + value.acc
                    ).success(
                        (data) ->
                            $scope.ordersNums = data
                            console.log data
                            $scope.$apply()
                    ).error(
                        (err) ->
                    )
                    console.log value.acc

            $scope.$watch "prevOrder", (value)  ->
                if value?
                    $.get(
                        "/order/previous/select/" + value.order_num
                    ).success(
                        (data) ->
                            $scope.orderItems = data.items
                            console.log data
                            $scope.$apply()
                    ).error(
                        (err) ->
                    )