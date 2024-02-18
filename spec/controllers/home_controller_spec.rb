# frozen_string_literal: true

require 'rails_helper'

describe HomeController, type: :request do
  let!(:post) { create(:post, status: 'active') }
  let!(:ruby_post) { create(:post, title: 'Ruby on Rails') }
  let!(:inactive_ruby_post) { create(:post, title: 'Ruby on Jets', status: 'inactive') }

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

        get post_path(post.slug)

        expect(Ahoy::Visit.count).to eq(1)
        expect(Ahoy::Event.count).to eq(1)
      end
    end

    context 'when visit the post and visit again within 3 hours' do
      it 'does not track again within 3 hours' do
        expect(Ahoy::Visit.count).to eq(0)
        expect(Ahoy::Event.count).to eq(0)

        get post_path(post.slug)
        get post_path(post.slug)

        expect(Ahoy::Visit.count).to eq(1)
        expect(Ahoy::Event.count).to eq(1)
      end
    end

    context 'when visiting the post and visiting again after 24 hours' do
      it 'tracks again after 24 hours' do
        expect(Ahoy::Visit.count).to eq(0)
        expect(Ahoy::Event.count).to eq(0)

        get post_path(post.slug)

        allow(Time).to receive(:now).and_return(25.hours.from_now)

        get post_path(post.slug)

        expect(Ahoy::Visit.count).to eq(2)
        expect(Ahoy::Event.count).to eq(2)
      end
    end

    context 'when look through different posts' do
      let(:post_first) { create(:post, status: 'active') }
      let(:post_second) { create(:post, status: 'active') }

      it 'tracking two different posts within 24 hours' do
        expect(Ahoy::Visit.count).to eq(0)
        expect(Ahoy::Event.count).to eq(0)

        get post_path(post_first.slug)
        get post_path(post_second.slug)

        expect(Ahoy::Visit.count).to eq(1)
        expect(Ahoy::Event.count).to eq(2)
      end
    end

    it 'returns a successful response, renders the show template, and includes post details' do
      get post_path(post.slug)

      expect(response).to be_successful
      expect(response).to render_template(:show)

      expect(response.body).to include(post.title).or(include(post.post_translations.find_by(locale: I18n.locale).title))
      expect(response.body).to include(post.description)
    end
  end

  describe 'GET #search' do
    it 'returns a successful response and renders the search template' do
      get search_path

      expect(response).to be_successful
      expect(response).to render_template(:search)
    end

    it 'returns a successful response and show correct results' do
      get search_path(query: 'ruby')

      expect(response).to be_successful
      expect(response).to render_template(:search)

      expect(response.body).to include(ruby_post.title)
      expect(response.body).not_to include(inactive_ruby_post.title)
    end
  end
end
