Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users, only: [:index , :show]
  scope "(:locale)", locale: /fr|en/ do
    get 'birthday', to: "pages#birthday", as: "birthday"
    get 'selection', to: "pages#selection", as: "selection"

    root to: "users#index", constraints: lambda { |r| r.env["warden"].authenticate? }
    root to: 'pages#home'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :channels, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :subscriptions, only: [:create, :destroy]
    resources :messages, only: [:create, :destroy]
  end

  get 'first-connection', to: "channels#first_connection"
  delete 'delete-selected-user/:id', to: "channels#delete_selected_user", as: "delete_selected_user"

  mount ActionCable.server => '/cable'
  mount Attachinary::Engine => "/attachinary"

end
