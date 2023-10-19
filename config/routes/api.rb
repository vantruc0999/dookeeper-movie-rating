namespace :api do
    namespace :v1 do
        scope :users, module: :users do
            post '/', to: "registrations#create", as: :user_registration
            get '/get-user', to: "users#get_user"
            get '/get-all-users', to: "users#get_all_users"
            post '/add-user', to: "users#add_user"
            post '/update-user', to: "users#update_user"
        end
        resources :books

        resources :genres 

        resources :movies

        resources :ratings

        resources :favorites

        namespace :android do
            resources :movies
        end
    end
end

scope :api do
    scope :v1 do
        use_doorkeeper do
            skip_controllers :authorizations, :applications, :authorized_applications
        end
    end
end