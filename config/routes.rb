FactoryScenarios::Engine.routes.draw do
  root :to => 'scenarios#index'

  resources :scenarios do
    member do
      get :enact
    end
  end
end
