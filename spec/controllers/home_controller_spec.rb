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
