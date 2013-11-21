Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :static_pages
  end
end
