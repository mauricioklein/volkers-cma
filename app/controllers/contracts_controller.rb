class ContractsController < ApplicationController
  before_action :load_contract, except: [:create]
  before_action :create_contract_service, except: [:create]

  rescue_from CustomErrors::ContractInactive, with: :contract_inactive_error

  def show
    render json: @contract_service.access_contract
  end

  def create
    render json: Contract.create!(
      contract_params.merge(
        user_id: current_user.id
      )
    )
  end

  def destroy
    @contract_service.deactivate_contract
    render status: :ok
  end

private

  def load_contract
    @contract ||= Contract.find(params[:id])
  end

  def create_contract_service
    @contract_service ||= ContractService.new(@contract, current_user)
  end

  def contract_inactive_error(error)
    render status: :not_found
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
