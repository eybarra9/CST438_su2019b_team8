Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/orders'    => 'orders#create'
  get  '/orders/:id' => 'orders#getItemById'
  get  '/orders'    => 'orders#getCustomerIdByEmail'
end
