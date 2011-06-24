Rails.application.routes.draw do
  match 'newsletters/:id' => 'newsletters#show', :as => 'newsletter'
  namespace :admin do
    resources :newsletters do
      post :add_module, :on => :collection
      post :remove_module, :on => :collection
      post :sort, :on => :collection
    end
  end
end
