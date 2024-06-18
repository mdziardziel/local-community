namespace :authentication do
  get '/user', to: 'users#show'
  get '/user/edit', to: 'users#edit'
  patch '/user', to: 'users#update'

  resources :user_sessions, only: %i(new create)
  delete '/user_sessions', to: 'user_sessions#destroy'
end