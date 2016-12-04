Rails.application.routes.draw do
  root to: "bikes#index"
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'sign_up', to: 'devise/registrations#new'
    delete 'sign_out', to: 'devise/sessions#destroy'
  end
  devise_for :users
  resources :bikes
end
