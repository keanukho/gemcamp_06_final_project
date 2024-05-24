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
    end
    root 'client/home#index', as: 'client_root'
  end
end
