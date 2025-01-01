FactoryBot.define do
  factory :transaction do
    account { nil }
    amount { 1 }
    transaction_type { "MyString" }
  end
end
