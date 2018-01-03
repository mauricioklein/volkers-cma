class ContractsController < ApplicationController
  before_action :current_user

  def show
    contract = Contract.find(params[:id])
    raise CustomErrors::Unauthorized if contract.user != @current_user
    render json: contract
  end

  def create
    render json: Contract.create!(contract_params.merge(user_id: current_user.id))
  end

  def destroy
    contract = Contract.find(params[:id])
    raise CustomErrors::Unauthorized if contract.user != @current_user
    contract.update(active: false)
    render status: :ok
  end

private

  def current_user
    @current_user = User.find_by!(token: token)
  rescue ActiveRecord::RecordNotFound
    raise CustomErrors::Unauthorized
  end

  def contract_params
    params
      .require(:contract)
      .permit(
        :vendor,
        :starts_on,
        :ends_on,
        :price
      )
  end
end
