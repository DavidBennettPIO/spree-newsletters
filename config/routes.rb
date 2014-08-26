Spree::Core::Engine.routes.draw do

  match 'newsletters/:id' => 'newsletters#show', :as => 'newsletter'
  namespace :admin do
    resources :newsletters do
      post :add_module, :on => :collection
      post :remove_module, :on => :collection
      post :sort, :on => :collection
      post :add_image
      get :new_copy
      post :create_copy
      match 'edit_copy/:newsletter_copy_id' => 'newsletters#edit_copy', :via => :get, :as => 'edit_copy'
      match 'update_copy/:newsletter_copy_id' => 'newsletters#update_copy', :via => :put, :as => 'update_copy'
      get :send_test
      get :send_email_to
      post :send_email
    end
    resources :newsletter_recipients
  end

end
