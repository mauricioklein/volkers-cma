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

  describe 'user' do
    it { is_expected.to validate_length_of(:user) }
    it { is_expected.to belong_to(:user) }
  end
end
