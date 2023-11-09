# frozen_string_literal: true

require 'rails_helper'

describe HomeController, type: :request do
  let!(:post) { create(:post) }

  describe 'GET #index' do
    it 'returns a successful response and renders the index template' do
      get root_path

      expect(response).to be_successful
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    context 'when visiting the post first time' do
      it 'tracks the post for the first time' do
        expect(Ahoy::Visit.count).to eq(0)
        expect(Ahoy::Event.count).to eq(0)

        get post_path(post)

        expect(Ahoy::Visit.count).to eq(1)
        expect(Ahoy::Event.count).to eq(1)
      end
    end

    context 'when visit the post and visit again within 3 hours' do
      it 'does not track again within 3 hours' do
        expect(Ahoy::Visit.count).to eq(0)
        expect(Ahoy::Event.count).to eq(0)

        get post_path(post)

        get post_path(post)

        expect(Ahoy::Visit.count).to eq(1)
        expect(Ahoy::Event.count).to eq(2)
      end
    end

    it 'returns a successful response, renders the show template, and includes post details' do
      get post_path(post)

      expect(response).to be_successful
      expect(response).to render_template(:show)

      expect(response.body).to include(post.title)
      expect(response.body).to include(post.description)
    end
  end

  describe 'GET #search' do
    it 'returns a successful response and renders the search template' do
      get search_path

      expect(response).to be_successful
      expect(response).to render_template(:search)
    end
  end
end
