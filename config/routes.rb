# config/routes.rb
Rails.application.routes.draw do
  constraints(AdminDomainConstraint.new) do
    devise_for :users, controllers: { sessions: 'admin/sessions' }, as: :admin
    root 'admin/home#index', as: 'admin_root'
  end

  constraints(ClientDomainConstraint.new) do
    devise_for :users, controllers: { sessions: 'client/sessions', registrations: 'client/registrations' }
    namespace :client, path: '' do
      resource :profile, only: [:show, :edit, :update]
      resources :addresses
      resources :invitepeople do
        get 'generate_qr_code', on: :collection
      end
    end
    root 'client/home#index', as: 'client_root'
  end

  namespace :api do
    namespace :v1 do
      resources :regions, only: %i[index show], defaults: { format: :json } do
        resources :provinces, only: :index, defaults: { format: :json }
      end

      resources :provinces, only: %i[index show], defaults: { format: :json } do
        resources :cities, only: :index, defaults: { format: :json }
      end

      resources :cities, only: %i[index show], defaults: { format: :json } do
        resources :barangays, only: :index, defaults: { format: :json }
      end

      resources :barangays, only: %i[index show], defaults: { format: :json }
    end
  end

end
