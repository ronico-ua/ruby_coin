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
    let(:ahoy) { instance_double(Ahoy::Tracker) }
    let(:request) { instance_double(ActionDispatch::Request, session: { last_visit: nil }) }

    it 'calls Ahoy::EventProcess and updates last_visit' do
      expect(ahoy).to receive(:visit)
      expect(ahoy).to receive(:track).with('Viewed Post', title: post.title, post_id: post.id)

      get post_path(post)

      expect(response).to have_http_status(:success)
      Ahoy::EventProcess.call(ahoy, post, request)
      expect(request.session[:last_visit]).not_to be_nil
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
