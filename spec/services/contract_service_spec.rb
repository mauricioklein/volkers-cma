require 'rails_helper'

RSpec.describe ContractService do
  subject(:service) { described_class.new(contract, current_user) }

  let(:contract) { create(:contract, user: owner) }
  let(:owner) { create(:user) }
  let(:current_user) { owner }

  describe '#access_contract' do
    subject { service.access_contract }

    context 'with access granted' do
      it { is_expected.to eq contract }
    end

    context 'with not owner contract' do
      let(:current_user) { build(:user) }

      it { expect { subject }.to raise_exception(CustomErrors::Unauthorized) }
    end

    context 'with inactive contract' do
      before { contract.mark_as_inactive! }

      it { expect { subject }.to raise_exception(CustomErrors::ContractInactive) }
    end
  end

  describe '#deactivate_contract' do
    subject { service.deactivate_contract }

    context 'owning the contract' do
      specify do
        subject
        expect(contract.reload.active).to be false
      end
    end

    context 'not owning the contract' do
      let(:current_user) { build(:user) }

      it { expect { subject }.to raise_exception(CustomErrors::Unauthorized) }
    end
  end
end
