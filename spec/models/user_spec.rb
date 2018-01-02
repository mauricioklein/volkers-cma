require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:full_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe 'email format' do
    subject { build(:user, email: email) }

    context 'with valid email' do
      let(:email) { 'peter.park@spiderman.com' }
      it { is_expected.to be_valid }
    end

    context 'with invalid email' do
      let(:email) { 'foobar' }
      it { is_expected.to be_invalid }
    end
  end

  describe 'password format' do
    subject { build(:user, password: password) }

    context 'with password >= 8 characters' do
      let(:password) { 'abcd1234' }
      it { is_expected.to be_valid }
    end

    context 'with password < 8 characters' do
      let(:password) { 'abcd' }
      it { is_expected.to be_invalid }
    end
  end
end
