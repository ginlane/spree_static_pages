Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :static_pages do
      member do
        put :approve
        put :disapprove
      end
    end
  end

  get "/s/*path", to: "static_pages#show"
end
