class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  def self.jwt_revoked?(payload, user)
    RevokedToken.exists?(jti: payload["jti"])
  end

  def self.revoke_jwt(payload, user)
    RevokedToken.create!(jti: payload["jti"], exp: Time.at(payload["exp"]))
  end
end
