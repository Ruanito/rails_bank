require 'rails_helper'

RSpec.describe "Transactions", type: :request do
  describe "POST /users/user_id/accounts/account_id/transactions" do
    describe "when create a deposit" do
      let!(:user) { FactoryBot.create(:user) }
      let!(:account) { FactoryBot.create(:account, user: user, balance: 0) }

      it 'should create a transaction' do
        post "/users/#{user.id}/accounts/#{account.id}/transactions", params: { transaction: { transaction_type: 'deposit', amount: 100 } }
        account.reload

        expect(response).to have_http_status(:created)
        expect(account.balance).to eq(100)
        expect(account.transactions.count).to be(1)
        expect(account.transactions.last.amount).to eq(100)
      end
    end

    describe "when create a withdraw" do
      let!(:user) { FactoryBot.create(:user) }
      let!(:account) { FactoryBot.create(:account, user: user, balance: 100) }

      it 'should create a transaction' do
        post "/users/#{user.id}/accounts/#{account.id}/transactions", params: { transaction: { transaction_type: 'withdraw', amount: 100 } }
        account.reload

        expect(response).to have_http_status(:created)
        expect(account.balance).to eq(0)
        expect(account.transactions.count).to be(1)
        expect(account.transactions.last.amount).to eq(100)
      end
    end
  end
end
