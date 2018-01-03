class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_error
  rescue_from CustomErrors::Unauthorized, with: :unauthorized_error

private

  def record_invalid_error(error)
    render status: :unprocessable_entity, json: { errors: error }
  end

  def unauthorized_error(error)
    render status: :unauthorized
  end
end
