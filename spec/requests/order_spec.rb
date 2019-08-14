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

    it 'retrieve item by id' do 
      headers =  { "CONTENT_TYPE" => "application/json" ,"ACCEPT" => "application/json"}
      Item.create('description' => 'gold chain','price' => 250.10 ,'stockQty' => 1 );
      get "/items/1",  :headers => headers
      expect(response).to have_http_status(200)
      items_response = JSON.parse(response.body)
      expect(items_response['id']).to eq 1
    end  
 
    it 'cannot find customerId by Email' do
        headers = { "CONTENT_TYPE" => "application/json" ,
                   "ACCEPT" => "application/json"} 
        get '/customers?email=ey@csumb.edu', :headers => headers
        expect(response).to have_http_status(404)
        
    end
    
    it 'orders item that is currently in stock' do
      headers =  { "CONTENT_TYPE" => "application/json" ,"ACCEPT" => "application/json"}
      item = Item.create('description' => 'gold chain','price' => 250.10 ,'stockQty' => 7 )
      order = {id: 1, itemId: item.id  }
      put "/items/order", :params => order.to_json,  :headers => headers
      expect(response).to have_http_status(204)      
      item.reload
      expect(item.stockQty).to eq 6 
    end
end 