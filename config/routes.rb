LinkChecker::Application.routes.draw do
  root 'sites#new'
  get '/sites/:id/edit', to: 'sites#edit', as: 'edit_site'
  get '/sites/new', to: 'sites#new', as: 'new_site'
  get '/sites/:id', to: 'sites#show', as: 'site'
  patch '/sites/:id', to: 'sites#update'
  delete '/sites/:id', to: 'sites#destroy'
  post '/sites', to: 'sites#create', as: 'sites'
  get '/linkfarm', to: 'sites#linkfarm'
end
