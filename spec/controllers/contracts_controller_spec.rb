require 'rails_helper'

RSpec.describe ContractsController, type: :controller do
  describe "GET #show" do
    subject do
      request.env['TOKEN'] = token
      get :show, params: { id: contract_id }
    end

    let!(:contract) { create(:contract, user: owner) }
    let(:contract_id) { contract.id }

    let(:owner) { create(:user, token: owner_token) }
    let(:owner_token) { 'ABCD1234' }

    let(:body) { JSON.parse(response.body, symbolize_names: true) }

    context 'user owns the contract' do
      let(:token) { owner_token }

      context 'and contract exists' do
        specify do
          subject
          expect(response).to have_http_status(:success)
          expect(body).to include(:id, :vendor, :starts_on, :ends_on, :price, :user_id, :active)
        end
      end

      context 'and contract does not exists' do
        let(:contract_id) { 123 }

        specify do
          subject
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'user not owns the contract' do
      let!(:other_user) { create(:user, email: 'bruce@wayne.com', token: token) }
      let(:token) { owner_token.reverse }

      specify do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'user not authenticated' do
      let(:token) { nil }

      specify do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE #destroy" do
    subject do
      request.env['TOKEN'] = token
      get :destroy, params: { id: contract_id }
    end

    let!(:contract) { create(:contract, user: owner) }
    let(:contract_id) { contract.id }

    let(:owner) { create(:user, token: owner_token) }
    let(:owner_token) { 'ABCD1234' }

    context 'user owns the contract' do
      let(:token) { owner_token }

      context 'and contract exists' do
        specify do
          subject
          expect(response).to have_http_status(:success)
          expect(contract.reload.active).to be false
        end
      end

      context 'and contract does not exists' do
        let(:contract_id) { 123 }

        specify do
          subject
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'user not owns contract' do
      let!(:other_user) { create(:user, email: 'bruce@wayne.com', token: token) }
      let(:token) { owner_token.reverse }

      specify do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'user not authenticated' do
      let(:token) { nil }

      specify do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
