FactoryScenarios::Engine.routes.draw do
  root :to => 'scenarios#index'

  resources :scenarios do
    member do
      get :enact
    end
  end

  resources :mail_previews
  get "/mail_previews/:mailer/:name" => "mail_previews#show", as: :show_mail_preview
end
