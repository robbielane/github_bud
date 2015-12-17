Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/auth/github', as: :login
  get '/auth/github/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/:profile', as: :profile, param: :login, to: 'profiles#show'
  get '/:profile/pull-requests', as: :pull_requests, to: 'pull_requests#index'
  put '/:profile/pull-requests/merge', as: :merge, to: 'pull_requests#merge'
  get '/:profile/:repo', as: :repo, param: :repo, format: false, to: 'repos#show'
end
