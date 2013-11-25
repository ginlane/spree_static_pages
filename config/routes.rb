Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :static_pages
  end

  get "/s/*path", to: "store/static_pages#show"
end
