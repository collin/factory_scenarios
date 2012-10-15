require "rubyception"
FactoryScenarios::Engine.routes.draw do
  root :to => 'environment#integration'

  mount Rubyception::Engine, at: '/rubyception'

  resources :scenarios do
    member do
      get :enact
    end
  end

  resources :mail_previews
  match "/mail_previews/:mailer/:name" => "mail_previews#show", as: :show_mail_preview
end
