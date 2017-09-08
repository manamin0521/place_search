Rails.application.routes.draw do
  resources :place_lists
    root to: redirect('/place_lists')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
