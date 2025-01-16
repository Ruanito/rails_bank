class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :transaction_type, :amount
end
