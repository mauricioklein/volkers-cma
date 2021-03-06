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

  describe 'password_digest' do
    it { is_expected.to validate_presence_of(:password_digest) }
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_length_of(:password_digest).is_at_least(8).on(:create) }
  end
end

# == Schema Information
# Schema version: 20180103080537
#
# Table name: users
#
#  id              :integer          not null, primary key
#  full_name       :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  token           :string
#
# Indexes
#
#  index_users_on_token  (token)
#
