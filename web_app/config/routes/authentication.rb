namespace :authentication do
  resources :users, only: %i(edit update)
end