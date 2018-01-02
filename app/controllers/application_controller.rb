class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_error

private

  def record_invalid_error(error)
    render status: :unprocessable_entity, json: { errors: error }
  end
end
