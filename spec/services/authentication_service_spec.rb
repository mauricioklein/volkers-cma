require 'rails_helper'

RSpec.describe AuthenticationService do

  describe '.login' do
    subject { described_class.login(user.email, password) }

    let(:user) { create(:user, password: user_password) }
    let(:user_password) { 'ABCD1234' }

    context 'with successful login' do
      let(:password) { user_password }

      it { is_expected.to be_a(String) }
    end

    context 'with failed login' do
      let(:password) { user_password.reverse }

      it { expect { subject }.to raise_error(CustomErrors::Unauthorized) }
    end
  end

  describe '.logout' do
    subject { described_class.logout(token) }

    let!(:user) { create(:user, token: user_token) }
    let(:user_token) { 'ABCD1234' }

    context 'with valid token' do
      let(:token) { user_token }

      specify do
        subject
        expect(user.reload.token).to be_nil
      end
    end

    context 'with invalid token' do
      let(:token) { user_token.reverse }

      it { expect { subject }.to raise_error(CustomErrors::Unauthorized) }
    end
  end
end
