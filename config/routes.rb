Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get     '/signup'         => 'signup#new'
  post    '/signup'         => 'signup#create'
  get     '/signup/confirm' => 'signup#confirm'
  post    '/signup/confirm' => 'signup#confirm_submit'
  get     '/signup/done'    => 'signup#done'

  get     '/login'         => 'login#new'
  post    '/login'         => 'login#auth'

  match "/auth/:provider/callback" => "sessions#callback"
  match "/logout" => "sessions#destroy", :as => :logout



end
