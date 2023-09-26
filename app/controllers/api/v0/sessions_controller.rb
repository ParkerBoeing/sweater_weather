class Api::V0::SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])
    if user
      if user.authenticate(params[:password])
        render json: UserSerializer.new(user)
      else
        render json: { error: "Invalid credentials" }, status: :bad_request
      end
    else
      render json: { error: "Invalid credentials" }, status: :bad_request
    end
  end
end