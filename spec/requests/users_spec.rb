require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /user" do
    describe 'when use a valid request' do
      it "should create a new user" do
        post "/users", params: { user: { email: Faker::Internet.email, name: Faker::FunnyName.name } }

        expect(response).to have_http_status(:created)
        expect(User.count).to eq(1)
      end
    end

    describe 'when use a invalid request' do
      let!(:user) { FactoryBot.create(:user) }

      it "should receive bad request from email already taken" do
        post "/users", params: { user: { email: user.email, name: Faker::FunnyName.name } }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)["email"]).to eq([ "has already been taken" ])
      end

      it "should receive bad request for empty params" do
        post "/users", params: { user: { email: "", name: "" } }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)["email"]).to eq([ "can't be blank" ])
        expect(JSON.parse(response.body)["name"]).to eq([ "can't be blank" ])
      end
    end
  end
end
