class ApplicationController < ActionController::API
  def authenticate_user!
    if request.headers["Authorization"].present?
      jwt_payload = JWT.decode(request.headers["Authorization"].split.last,
                               Rails.application.credentials.devise_jwt_secret_key!).first

      if RevokedToken.exists?(jti: jwt_payload["jti"])
        render json: {
          message: "Invalid token"
        }, status: :unauthorized
      end

      @current_user = User.find(jwt_payload["sub"])
      unless @current_user
        render json: {
          message: "Invalid token"
        }, status: :unauthorized
      end
    else
      render json: {
        message: "Invalid token"
      }, status: :unauthorized
    end
  end
end
