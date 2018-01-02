require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "POST #create" do
    subject! { post :create, params: { user: user_payload } }

    let(:valid_payload) do
      {
        full_name: 'Peter Park',
        email: 'peter@park.com',
        password: '12345678'
      }
    end

    let(:body) { JSON.parse(response.body, symbolize_names: true) }

    context 'with valid user payload' do
      let(:user_payload) { valid_payload }

      specify do
        expect(response).to have_http_status(:success)
        expect(body).to include(user_payload)
      end
    end

    context 'with invalid user payload' do
      let(:user_payload) { valid_payload.merge(full_name: '') }

      specify do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(body[:errors]).to eq "Validation failed: Full name can't be blank"
      end
    end
  end
end
