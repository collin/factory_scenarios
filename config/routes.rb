Rails.application.routes.draw do
  resources :factory_scenarios do
    member do
      get :enact
    end
  end
end
