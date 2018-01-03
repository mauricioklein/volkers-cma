class AuthenticationService
  class << self
    def login_by_email_and_pass(email, password)
      handling_not_found do
        user = User.find_by!(email: email)
        raise CustomErrors::Unauthenticated unless user.authenticate(password)
        user.update(token: SecureRandom.hex)
        user.token
      end
    end

    def login_by_token(token)
      handling_not_found do
        User.find_by!(token: token)
      end
    end

    def logout(token)
      handling_not_found do
        user = User.find_by!(token: token)
        user.update(token: nil)
      end
    end

    def handling_not_found
      yield
    rescue ActiveRecord::RecordNotFound
      raise CustomErrors::Unauthenticated
    end
  end

  private_class_method :handling_not_found
end
