class ContractService
  attr_reader :contract, :current_user

  def initialize(contract, current_user)
    @contract = contract
    @current_user = current_user
  end

  def access_contract
    raise CustomErrors::ContractInactive unless contract.active?
    raise CustomErrors::Unauthorized unless user_owns_contract?
    contract
  end

  def deactivate_contract
    raise CustomErrors::Unauthorized unless user_owns_contract?
    contract.mark_as_inactive!
    true
  end

private

  def user_owns_contract?
    contract.owner == current_user
  end
end
