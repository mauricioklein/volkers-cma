class UsersController < ApplicationController
  def create
    render json: User.create!(user_params)
  end

private

  def user_params
    params
      .require(:user)
      .permit(
        :full_name,
        :email,
        :password
      )
  end
end
