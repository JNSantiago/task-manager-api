require 'rails_helper'

RSpec.describe 'Users API', type: :request do
	let!(:user) { create(:user) }
	let(:user_id) { user.id }

	before { host! "api.taskmanager.dev" }

	describe "GET /users/:id" do
		
		before do
			headers = { "Accept" => "application/vnd.taskmanager.v1" }
			get "/users/#{user_id}", params: {}, headers: headers
		end

		context "Quando o usuário quando existir no banco" do
			it "Quando retornar usuário" do
				user_response = JSON.parse(response.body)
				expect(user_response["id"]).to eq(user_id)
			end

			it "Retorna o código de status 200" do
				expect(response).to have_http_status(200)
			end

		end

		context "Quando o usuário não existir no banco" do
			let(:user_id) { 10000 }

			it "Quando o usuário não existe" do
				expect(response).to have_http_status(404)
			end
		end
	end

	describe "POST /users" do
		before do
			headers = { 'Accept' => 'application/vnd.taskmanager.v1' }
			post '/users', params: { user: user_params }, headers: headers
		end

		context "Quando os parametros da requisição forem válidos" do
			let(:user_params) { FactoryGirl.attributes_for(:user) }

			it 'retorne 201' do
				expect(response).to have_http_status(201)
			end

			it 'retorne json para o usuario' do
				user_response = JSON.parse(response.body)
				expect(user_response['email']).to eq(user_params[:email])
			end
		end

		context "Quando os parametros da requisição forem invalidos" do
			let(:user_params) {attributes_for(:user, email: 'invalid_email@')}

			it 'retorne 422' do
				expect(response).to have_http_status(422)
			end

			it 'retorne json para o usuario' do
				user_response = JSON.parse(response.body)
				expect(user_response).to have_key('errors')
			end
		end
	end

end