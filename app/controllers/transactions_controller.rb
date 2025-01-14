class TransactionsController < ApplicationController
  before_action :set_user, only: [ :create ]
  def index; end
  def create
    account = @current_user.accounts.find_by(id: params[:account_id])

    amount = params[:transaction][:amount].to_i
    transaction_type = params[:transaction][:transaction_type]

    case transaction_type
    when "deposit"
      account.update(balance: account.balance + amount)
    when "withdraw"
      account.update(balance: account.balance - amount)
    end

    @transaction = account.transactions.create(transaction_type: transaction_type, amount: amount)

    if @transaction.save
      render json: @transaction, status: :created
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end
end
