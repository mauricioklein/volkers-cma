require 'rails_helper'

RSpec.describe Contract, type: :model do
  describe 'vendor' do
    it { is_expected.to validate_presence_of(:vendor) }
  end

  describe 'starts_on/ends_on' do
    subject { build(:contract, starts_on: starts_on, ends_on: ends_on) }
    let(:starts_on) { Date.today }
    let(:ends_on) { Date.tomorrow }

    it { is_expected.to validate_presence_of(:starts_on) }
    it { is_expected.to validate_presence_of(:ends_on) }

    context 'starts_on is before than ends_on' do
      it { is_expected.to be_valid }
    end

    context 'starts_on is after than ends_on' do
      let(:ends_on) { Date.yesterday }
      it { is_expected.to be_invalid }
    end
  end

  describe 'price' do
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to allow_value(15.00).for(:price) }
    it { is_expected.to allow_value(0).for(:price) }
    it { is_expected.to_not allow_value(-15.00).for(:price) }
  end

  describe 'user (a.k.a. owner)' do
    it { is_expected.to validate_length_of(:user) }
    it { is_expected.to belong_to(:user) }
  end

  describe '#mark_as_inactive!' do
    subject { contract.mark_as_inactive! }

    let(:contract) { create(:contract) }

    specify do
      subject
      expect(contract.reload.active).to be false
    end
  end
end

# == Schema Information
#
# Table name: contracts
#
#  id         :integer          not null, primary key
#  vendor     :string
#  starts_on  :date
#  ends_on    :date
#  price      :float
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  active     :boolean
#
# Indexes
#
#  index_contracts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
