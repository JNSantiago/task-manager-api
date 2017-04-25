require 'api_version_constraint' # libs/api_version_constraint.rb
Rails.application.routes.draw do

  # devise_for :users
	# api.task-manager.dev:3000/resource
	# defaults = especifica o formato de transferẽncia de dados
	# constraints = cria um subdominio com o nome api.
	# path = remove o namespace 'api' da URL
	namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
		# ApiVersionConstraint = recebe o número da versão no header.
		namespace :v1, path: '/', constraints: ApiVersionConstraint.new(version: 1, default: true) do
			resources :users, only: [:show, :create, :update, :destroy]
		end
	end
end
