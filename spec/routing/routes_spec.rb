# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Routes' do
  describe 'GET /' do
    it 'routes to home#index' do
      expect(get: '/').to route_to('home#index')
    end
  end

  describe 'GET /search' do
    it 'routes to home#search' do
      expect(get: '/search').to route_to('home#search')
    end
  end

  describe 'GET /faq' do
    it 'routes to faq#index' do
      expect(get: '/faq').to route_to('faq#index')
    end
  end

  describe 'GET /post/1' do
    it 'routes to home#show' do
      expect(get: '/post/1').to route_to('home#show', id: '1')
    end
  end

  describe 'GET /management' do
    it 'routes to management/posts#index' do
      expect(get: '/management').to route_to('management/posts#index')
    end
  end

  describe 'GET /management/posts' do
    it 'routes to management/posts#index' do
      expect(get: '/management/posts').to route_to('management/posts#index')
    end
  end

  describe 'GET /management/tags' do
    it 'routes to management/tags#index' do
      expect(get: '/management/tags').to route_to('management/tags#index')
    end
  end

  describe 'GET /api/tags' do
    it 'routes to api/tags#index' do
      expect(get: '/api/tags').to route_to('api/tags#index')
    end
  end

  describe 'Devise routes' do
    describe 'GET /users/sign_up' do
      it 'routes to users/registrations#new' do
        expect(get: '/users/sign_up').to route_to('users/registrations#new')
      end
    end

    describe 'POST /users' do
      it 'routes to users/registrations#create' do
        expect(post: '/users').to route_to('users/registrations#create')
      end
    end

    describe 'GET /users/sign_in' do
      it 'routes to users/sessions#new' do
        expect(get: '/users/sign_in').to route_to('users/sessions#new')
      end
    end

    describe 'POST /users/sign_in' do
      it 'routes to users/sessions#create' do
        expect(post: '/users/sign_in').to route_to('users/sessions#create')
      end
    end

    describe 'DELETE /users/sign_out' do
      it 'routes to users/sessions#destroy' do
        expect(delete: '/users/sign_out').to route_to('users/sessions#destroy')
      end
    end
  end
end
