class Api::V0::UsersController < ApplicationController

  def create
    begin
      user = User.create!(user_params)
      render json: UserSerializer.new(user)
    rescue => e
      render json: { error: e.message }, status: :bad_request
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end