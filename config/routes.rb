Rails.application.routes.draw do
  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  scope 'api/v1' do
    devise_for :users, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'api/v1/user_sessions',
      registrations: 'api/v1/user_registrations'
    }

    devise_scope :user do
      post '/generate_otp', to: 'api/v1/user_registrations#generate_otp'
    end
  end
end
