Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :candidates

      resources :companies do
        resources :job_listings, only: [:create]
      end

      resources :job_listings, except: [:create] do
        member do
          # candidate create candidates_job_listing
          post :apply
          # candidate destroy candidates_job_listing
          delete :remove
        end
      end

      # update state of candidates_job_listing, company token req
      resources :candidates_job_listings, only: [:index, :show, :update]

    end
  end

end
