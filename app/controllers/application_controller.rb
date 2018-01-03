class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_error
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_error
  rescue_from CustomErrors::Unauthorized, with: :unauthorized_error

private

  def record_invalid_error(error)
    render status: :unprocessable_entity, json: { errors: error }
  end

  def record_not_found_error(error)
    render status: :not_found, json: { errors: error }
  end

  def unauthorized_error(error)
    render status: :unauthorized
  end

  def token
    request.env['TOKEN']
  end
end
