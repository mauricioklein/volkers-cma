class UsersController < ApplicationController
  def create
    render json: User.create!(user_params)
  end

  def login
    render json: {
      token: AuthenticationService.login_by_email_and_pass(email, password)
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

  def email
    user_params[:email]
  end

  def password
    user_params[:password]
  end
end
