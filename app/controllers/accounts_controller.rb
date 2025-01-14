class AccountsController < ApplicationController
  before_action :set_user, only: [ :index, :create ]
  def create
    account = @current_user.accounts.create({ balance: 0 })

    if account.save
      render json: account, status: :created
    else
      render json: account.errors, status: :bad_request
    end
  end

  def index
    accounts = @current_user.accounts

    render json: accounts, status: :ok
  end
end
