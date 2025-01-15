class TransactionsController < ApplicationController
  before_action :set_user, only: [ :create ]
  def index; end
  def create
    account = @current_user.accounts.find_by(id: params[:account_id])

    ActiveRecord::Base.transaction do
      @transaction = account.add_transaction(transaction_type: transaction_params[:transaction_type], amount: transaction_params[:amount].to_i)

      if @transaction.save
        render json: @transaction, status: :created
      else
        render json: @transaction.errors, status: :unprocessable_entity
      end
    end
  end

  private

  def transaction_params
    params.expect(transaction: [ :transaction_type, :amount ])
  end
end
