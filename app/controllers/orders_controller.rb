class OrdersController < ApplicationController
    # Create a new Order (POST /orders)
    def create
        @order = Order.new
        
        code, customer = Customer.getCustomerByEmail(params [:email])
        if code != 200
            render json:{error: "ERROR: Cannot find Customer Email. #{params[:email]}"},
            status: 400
            return
        end 
        
        code, item = Item.getItemById(params [:itemId])
        if code != 200
            render json:{error: "ERROR: Cannot find Item Id. #{params[:itemId]}"},
            status: 400
            return
        end 
        
        if item[:stockQty] <= 0
            render json:{error: "Item is not in stock."},
            status: 400
         return
        end
        
        @order.itemId = params[:itemId]
        @order.customerId = customer[:customerId]
        @order.description = item[:description]
        @order.price = item[:price]
        @order.award = customer[:award]
        @order.total = @order.price - @order.award
        
        if @order.save
            code = Customer.addOrder(@order)
            code = Item.addOrder(@order)
            render json: @order, status: 201
        else
            render json: @order.errors, status: 404
        end 
    end 
    
    # Find item by itemId and return if in stock  GET /orders?customerId=nnn
    # NOT 100% SURE THIS ONE IS CORRECT
    def getItemById
        itemId = params['itemId']
         if itemId != nil
             code, item = Item.getItemById(params [:itemId])
             if code != 200
                render json:{error: "ERROR: Unable to find item id. #{itemId}"},
                status: 404
            return itemId = Item[:itemId]
             end
            if item[:stockQty] <= 0
                render json:{error: "Item is not in stock."},
            status: 400
            return
            end
         end
             orders = @order.where(itemId: itemId)
             render json: orders, status: 200
             
    end 

    
    # Get customerId by Email and return award  (GET /orders?email=nn@nnnn)
    def getCustomerIdByEmail
        customerId = params['customerId']
        award = params['award']
        email = params['email']
        if email != nil
            code, customer = Customer.getCustomerByEmail(email)
            if code != 200
                render json:{error: "ERROR: Unable to find Customer Email. #{email}"},
                status: 404
            return 
            end
            customerId = customer[:id]
            award = customer[:award]
        end 
        orders = @order.where(customerId: customerId)
        render json: orders, status: 200
    end
    
    def processOrder
        p = params
        @customer = Customer.find_by(:id => params[:customerId])
        p = @customer
        if @customer == nil
            head 404
        else
            @customer.processOrder(params)
            @customer.save
            head 200
        end
    end 
    
    
end    
