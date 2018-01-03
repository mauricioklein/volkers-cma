class ContractsController < ApplicationController
  before_action :current_user

  def show
    contract = Contract.find(params[:id])
    raise CustomErrors::Unauthorized if contract.user != @current_user
    render json: contract
  end

  def create
  end

  def delete
  end

private

  def current_user
    @current_user = User.find_by!(token: token)
  rescue ActiveRecord::RecordNotFound
    raise CustomErrors::Unauthorized
  end
end
