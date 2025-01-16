class AccountSerializer < ActiveModel::Serializer
  attributes :id, :balance

  has_one :transactions
end
