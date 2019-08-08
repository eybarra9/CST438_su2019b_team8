class OrdersController < ApplicationController
    # Create a new Order (POST /orders)
    def create
        @order = Order.new

        @order.save
        render json: @customer.to_json, status:201
    end
    
     #GET /orders/:id 
    def getId
    end 
    
    #GET /orders?customerId=nnn
    def findOrderById
    end 
    
    #GET /orders?email=nn@nnnn
    def findOrderByEmail
    end 
    
    
    
end    