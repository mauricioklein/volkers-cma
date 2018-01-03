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
        expect(body).to include(:id, :full_name, :email)
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

  describe "GET #login" do
    subject! { get :login, params: { user: login_payload } }
    let(:user) { create(:user, password: password) }
    let(:password) { '12345678' }

    let(:body) { JSON.parse(response.body, symbolize_names: true) }

    context 'with successful login' do
      let(:login_payload) { { email: user.email, password: password } }

      specify do
        expect(response).to have_http_status(:success)
        expect(body).to include(:token)
      end
    end

    context 'with failed login' do
      let(:login_payload) { { email: user.email, password: password.reverse } }

      it { expect(response).to have_http_status(:forbidden) }
    end
  end

  describe "GET #logout" do
    subject do
      request.env['TOKEN'] = token
      get :logout
    end
    let!(:user) { create(:user, token: user_token) }
    let(:user_token) { 'ABCD1234' }

    context 'with valid token' do
      let(:token) { user_token }

      specify do
        subject
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid token' do
      let(:token) { user_token.reverse }

      specify do
        subject
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
