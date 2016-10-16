Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations", omniauth_callbacks: "omniauth_callbacks" }
  root to: "pages#home"

  resources :identities, only: :destroy
end
