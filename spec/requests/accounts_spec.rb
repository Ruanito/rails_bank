require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  describe "POST /user/:user_id/accounts" do
    let!(:user) { FactoryBot.create(:user) }

    it "should create a new account" do
      post "/users/#{user.id}/accounts", params: {}

      expect(response).to have_http_status(:created)
      expect(user.accounts.count).to be(1)
    end
  end
end
