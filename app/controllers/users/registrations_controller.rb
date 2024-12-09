# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :validate_email, only: [ :create ]

  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      @token = request.env["warden-jwt_auth.token"]
      headers["Authorization"] = @token

      render json: {
        status: { code: 200, message: "Signed up successfully.",
                  token: @token,
                  data: resource }
      }
    else
      render json: {
        status: { message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end

  def validate_email
    if User.exists?(email: params[:user][:email])
      render json: { message: "Invalid email" }, status: :unprocessable_entity
    end
  end
end
