require 'httparty'

class OrderClient
    include HTTParty
    
    base_uri "http://localhost:8080"
    format :json
    
    def self.create(order)
        post '/orders', body: order.to_json, headers: { 'Content-Type' => 'application/json', 'ACCEPT' => 'application/json' }
    end
end

class CustomerClient

	include HTTParty
	# default_options.update(verify: false) # Turn off SSL
	base_uri "http://localhost:8081"
	format :json
	  
	def self.register(c)
	    get '/customers', body: cust.to_json,
	            headers: {'Content-Type' => 'application/json', 'ACCEPT' => 'application/json' }
	end
	
	def self.getId(id)
	    get "/customers?id=#{id}"
	end
	
	def self.getEmail(email)
	    get "/customers?id=#{email}"
	end
end 
    
class ItemClient
    include HTTParty
    
    base_uri "http://localhost:8082"
    
    format :json
    
    def self.create(item)
        post '/items', body: item.to_json,
            headers: { 'Content-Type' => 'application/json', 'ACCEPT' => 'application/json' }
    end
    
    def self.update(item)
        put "/items/#{item[:id]}", body: item.to_json, 
            headers:  { 'Content-Type' => 'application/json', 'ACCEPT' => 'application/json' }
    end
    
    def self.getId(id)
        get "/items/#{id}"
    end
end

while true
    puts "What would you like to do: (1) Create a new order, (2) retreive an existing order, (3) register a new customer, 
          (4) lookup a customer, (5) create a new item, (6) lookup an item or (7) quit ?"
    input = gets.chomp!
    
    case input
        when '7' || 'quit'
            break

    when '1'
            puts 'You want to create a new order. Enter Customer Id, Item Id, and price for the new order:'
            input = gets.chomp!.split()
            response = OrderClient.create customerId: input[0], itemId: input[1], price: input[2]
            puts "status code #{response.code}"
            puts response.body
        when 'id'
            puts 'To look customer by Id, enter id '
            custId = gets.chomp!
            response = CustomerClient.getId(custId)
            puts "status code #{response.code}"
            puts response
        when 'email'
            puts 'To look customer by Email, enter email '
            customerInput = gets.chomp!
            response = CustomerClient.getEmail(customerInput)
            puts "status code #{response.code}"
            puts response
            
    end
end
          
          