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
    puts "What would you like to do:  (1) Create a new order, 
                            (2) retreive an existing order, 
                            (3) register a new customer, 
                            (4) lookup a customer, 
                            (5) create a new item, 
                            (6) lookup an item or 
                            (7) quit ?"
    input = gets.chomp!
    
    case input

        when '1'
            puts 'Enter an item ID'
            itemId = gets.chomp!
            puts 'Enter an email'
            email = gets.chomp!
            response = OrderClient.create itemId: itemId, email: email
            puts "status code #{response.code}"

        when '2'
            puts 'Enter an ID of the order to search for'
            id = gets.chomp!
            response = OrderClient.getId(id)
            puts "status code #{response.code}"
            
        when '3'
            puts 'To register a customer please enter the lastname, firstname and email separated by a blank space'
            input = gets.chomp!.split()
            response = CustomerClient.register lastName: input[0], firstName: input[1], email: input[2]
            puts "status code #{response.code}"
            
        when '4'
            puts 'To lookup a customer enter a customer ID or email'
            input = gets.chomp!
            if input.include?('@')
                response = CustomerClient.getEmail(input)
            else 
                response = CustomerClient.getId(input)
            end 
            puts "status code #{response.code}"
            
        when '5'
            puts "To create an item enter item description, price and stockQty all separated by a black space"
            input = gets.chomp!.split()
            response = ItemClient.create description: input[0], price: input[1], stockQty: input[2]
            puts "status code #{response.code}"
            
        when '6'
            puts "To look up an item enter the ID of item to search for"
            input = gets.chomp!
            response = ItemClient.getId(id)
            puts "status code #{response.code}"
            
        when '7'
            break
            
    end
end
          
          