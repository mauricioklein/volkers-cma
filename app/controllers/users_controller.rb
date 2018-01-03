class UsersController < ApplicationController
  def create
    render json: User.create!(user_params)
  end

  def login
    render json: {
      token: AuthenticationService.login(user_params[:email], user_params[:password])
    }
  end

  def logout
    AuthenticationService.logout(token)
    render status: :ok
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

  def token
    request.env['TOKEN']
  end
end
