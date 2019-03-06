Rails.application.routes.draw do
  devise_for :users
  resources :items, only: %i{new create update edit index} do
    post :get_barcode, on: :collection, as: :get_barcode
  end
  post "/items/:id/perform", to: "items#perform", as: :perform
  resources :supplier_details, only: %i{create update edit}
  root "pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
