class ApplicationController < ActionController::API
  def set_user
    current_user
  end

  def current_user
    @current_user ||= User.find_by(id: params[:user_id]) if params[:user_id]
  end
end
