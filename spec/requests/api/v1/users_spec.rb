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

end