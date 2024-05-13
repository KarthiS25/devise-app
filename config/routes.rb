Rails.application.routes.draw do
  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  scope 'api/v1/student' do
    devise_for :students, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'api/v1/student/student_sessions',
      registrations: 'api/v1/student/student_registrations'
    }

    devise_scope :student do
      post '/generate_otp', to: 'api/v1/student/student_registrations#generate_otp'
    end
  end

  namespace :api do
    namespace :v1 do
      put '/user/update', to: 'users#update'
    end
  end
end
