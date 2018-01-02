require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'full_name' do
    it { is_expected.to validate_presence_of(:full_name) }
  end

  describe 'email' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to allow_value('peter@park.com').for(:email) }
    it { is_expected.to_not allow_value('foobar').for(:email) }
  end

  describe 'password' do
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(8).on(:create) }
  end
end
