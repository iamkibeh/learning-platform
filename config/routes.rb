Rails.application.routes.draw do
  get '/current_user', to: 'current_user#index'
 devise_for :users, controllers: {
  sessions: 'users/sessions',
  registrations: 'users/registrations',
  passwords: 'users/passwords',
  confirmations: 'users/confirmations'
  },
  path: 'auth',
  path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
