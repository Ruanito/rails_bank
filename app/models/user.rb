class User < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true

  has_many :accounts, dependent: :destroy
end
