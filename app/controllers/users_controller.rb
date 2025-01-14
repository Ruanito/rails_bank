class UsersController < ApplicationController
  def index
    @users = User.all

    render json: @users, status: :ok
  end
  def show
    user = User.find(params[:id])

    if user.present?
      render json: user, status: :ok
    else
      render status: :not_found
    end
  end
  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
