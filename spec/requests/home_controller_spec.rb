# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:post) { create(:post) }

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      user = create(:user)
      post = create(:post, user:)
      get :show, params: { id: post.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #search' do
    it 'returns a successful response' do
      get :search
      expect(response).to have_http_status(:success)
    end
  end
end
