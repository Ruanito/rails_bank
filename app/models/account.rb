class Account < ApplicationRecord
  belongs_to :user

  has_many :transactions, dependent: :destroy

  def add_transaction(transaction_type:, amount:)
    case transaction_type
    when "deposit"
      self.update(balance: self.balance + amount)
    when "withdraw"
      self.update(balance: self.balance - amount)
    end

    self.transactions.create(transaction_type: transaction_type, amount: amount)
  end
end
