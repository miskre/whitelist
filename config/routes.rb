Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  scope "(:locale)", locale: /en/  do
    root "account/home#status"
    namespace :account do
      resources :users, only: [:create] do
        member do
          get 'confirm_email'
        end
      end

      get    'sign_in'         => 'sessions#new'
      post   'sign_in'         => 'sessions#create'
      get    'otp'             => 'sessions#otp'
      post   'two_factor_auth' => 'sessions#two_factor_auth'
      get    'sign_up' => 'users#new'
      patch   'users/token_update_user'
      get 'sign_out'        => 'sessions#destroy'

      get 'password/forget' => 'password_reset#new'
      get 'password/reset' => 'password_reset#show'
      post 'password/reset' => 'password_reset#update'
      post 'password/reset_request' => 'password_reset#create'
      get 'password/mail_sent' => 'password_reset#mail_sent'

      get 'info' => 'home#index'
      post 'basic_info' => 'home#create_info'
      patch 'basic_info' => 'home#update_info'
      get 'verify' => 'home#verify'
      get 'update_verify' => 'home#verify'
      patch 'update_verify' => 'home#update_verify'
      get 'status' => 'home#status'
      root to: 'home#status'

    end

    namespace :operator do
      resources :reasons
      resources :wallet_users do
        resources :wallet_kyc_papers
      end
      
      resources :mail_contents, only: [:index, :edit, :update]
      resources :broadcast_mails, only: [:index, :new, :create, :show]
      resources :users
      resources :kyc_pending_wallet_users, only: [:index, :edit, :update]
      resources :mail_contents, only: [:index, :update, :edit]

      resource :maintenance_setting, only: [:show, :update]

      get    'sign_in'          => 'sessions#new'
      post   'sign_in'          => 'sessions#create'
      get    'otp'              => 'sessions#otp'
      post   'two_factor_auth'  => 'sessions#two_factor_auth'
      delete 'sign_out'         => 'sessions#destroy'

      root to: 'home#index'
    end
  end
end
