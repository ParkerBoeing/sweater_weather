class Api::V0::UsersController < ApplicationController

  def create
    require 'pry'; binding.pry
    User.create!(user_params)
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end