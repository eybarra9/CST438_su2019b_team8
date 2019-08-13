require 'rails_helper'

RSpec.describe "OrdersController", type: :request do
 
 # Tests the create method (POST /customers)   
    it 'creates a new order' do
        headers = { "CONTENT_TYPE" => "application/json" ,
                   "ACCEPT" => "application/json"} 
        order = { 'CustomerId'=> '1','itemId' => '3', 'description'=> 'Macbook Air', 'total'=> '1300'}
        post '/orders',  :params => order.to_json, :headers => headers
        expect(response).to have_http_status(201)
        order_response = JSON.parse(response.body) 
        expect(order_response).to include order
        #allow(CityWeather).to receive(:for) { 300 }
        
        #Testing if database has been updated
        orderdb = Order.find_by(CustomerId: '1')
        expect(orderdb).to be_truthy
        expect(orderdb.itemId).to eq '3'
        expect(orderdb.description).to eq 'Mackbook Air'
        expect(orderdb.total).to eq '1300'

    end

    it 'Finds item by Item id' do
        headers = { "CONTENT_TYPE" => "application/json" ,
                   "ACCEPT" => "application/json"} 
      

    end
 
    it 'get customerId by Email and returns award' do
        headers = { "CONTENT_TYPE" => "application/json" ,
                   "ACCEPT" => "application/json"} 

        
    end
    
    it 'cannot find customerId by Email' do
        headers = { "CONTENT_TYPE" => "application/json" ,
                   "ACCEPT" => "application/json"} 

        
    end
    
     it 'Finds item by Item id' do
        headers = { "CONTENT_TYPE" => "application/json" ,
                   "ACCEPT" => "application/json"} 


    end
    
     it 'Finds item by Item id and returns "Not in stock" ' do
        headers = { "CONTENT_TYPE" => "application/json" ,
                   "ACCEPT" => "application/json"} 
        customer = { 'firstName'=> 'Mercedes','lastName' => 'Garcia', 'email'=> 'mg@csumb.edu'}


    end
    
=end    
end 