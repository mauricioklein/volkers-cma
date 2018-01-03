class AuthenticationService
  class << self
    def login(email, password)
      user = User.find_by!(email: email)
      raise CustomErrors::Unauthorized unless user.authenticate(password)
      user.update(token: SecureRandom.hex)
      user.token
    end

    def logout(token)
      user = User.find_by!(token: token)
      user.update(token: nil)
    rescue ActiveRecord::RecordNotFound
      raise CustomErrors::Unauthorized
    end
  end
end
