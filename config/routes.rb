Rails.application.routes.draw do
  match 'newsletters/:id' => 'newsletters#show'
end
