# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::TagsController, type: :controller do
  describe 'GET #index' do
    let!(:tag_crypto) { create(:tag, title: 'Cryptocurrency') }
    let!(:tag_bitcoin) { create(:tag, title: 'Bitcoin') }
    let!(:tag_ethereum) { create(:tag, title: 'Ethereum') }

    context 'when searching with a term' do
      it 'returns matching tags serialized with TagBlueprint' do
        get :index, params: { term: 'coin' }

        expect(response).to have_http_status(:ok)
        json_response = response.parsed_body

        # 'Bitcoin' contains 'coin'
        expect(json_response.length).to eq(1)
        expect(json_response.first['title']).to eq('Bitcoin')
        expect(json_response.first['id']).to eq(tag_bitcoin.id)
      end

      it 'performs a matching search' do
        get :index, params: { term: 'Crypt' }

        expect(response).to have_http_status(:ok)
        json_response = response.parsed_body

        expect(json_response.length).to eq(1)
        expect(json_response.first['title']).to eq('Cryptocurrency')
        expect(json_response.first['id']).to eq(tag_crypto.id)
      end
    end

    context 'when searching with a blank term' do
      it 'returns all tags' do
        get :index, params: { term: '' }

        expect(response).to have_http_status(:ok)
        json_response = response.parsed_body

        expect(json_response.length).to eq(3)
        titles = json_response.pluck('title')
        expect(titles).to include('Cryptocurrency', 'Bitcoin', 'Ethereum')
      end
    end
  end
end
