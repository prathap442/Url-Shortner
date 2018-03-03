Rails.application.routes.draw do
   get '/:encoded_link', to: 'links#show'
  resources :operating_systems
  devise_for :users
  resources :links
  resources :user_links
  resources :logs
  resources :devices 
  root 'links#index' 
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
