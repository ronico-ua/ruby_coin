# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ActiveAdmin policy', type: :system do
  context 'when admin' do
    before do
      admin_user = create(:user, :admin_user)
      sign_in(admin_user)
    end

    it 'go to /admin' do
      get '/admin'
      expect(response.body).to include(I18n.t('active_admin.dashboard'))
    end

    it 'go to /admin/posts' do
      get '/admin/posts'
      expect(response.body).to include(I18n.t('active_admin.posts'))
    end

    it 'go to /admin/users' do
      get '/admin/users'
      expect(response.body).to include(I18n.t('active_admin.users'))
    end

    it 'go to /admin/tags' do
      get '/admin/tags'
      expect(response.body).to include(I18n.t('active_admin.tags'))
    end
  end

  context 'when user' do
    before do
      user = create(:user)
      sign_in(user)
    end

    it 'go to /admin' do
      get '/admin'
      expect(response.location).to eq(root_url)
    end

    it 'go to /admin/posts' do
      get '/admin/posts'
      expect(response.location).to eq(root_url)
    end

    it 'go to /admin/users' do
      get '/admin/users'
      expect(response.location).to eq(root_url)
    end

    it 'go to /admin/tags' do
      get '/admin/tags'
      expect(response.location).to eq(root_url)
    end
  end

  context 'when NOT authorized' do
    it 'go to /admin' do
      get '/admin'
      expect(response.location).to eq(new_user_session_url)
    end

    it 'go to /admin/posts' do
      get '/admin/posts'
      expect(response.location).to eq(new_user_session_url)
    end

    it 'go to /admin/users' do
      get '/admin/users'
      expect(response.location).to eq(new_user_session_url)
    end

    it 'go to /admin/tags' do
      get '/admin/tags'
      expect(response.location).to eq(new_user_session_url)
    end
  end

  context 'when moderator' do
    before do
      moderator = create(:user, :moderator_user)
      sign_in(moderator)
    end

    it 'go to /admin' do
      get '/admin'
      expect(response.location).to eq(root_url)
    end

    it 'go to /admin/posts' do
      get '/admin/posts'
      expect(response.location).to eq(root_url)
    end

    it 'go to /admin/users' do
      get '/admin/users'
      expect(response.location).to eq(root_url)
    end

    it 'go to /admin/tags' do
      get '/admin/tags'
      expect(response.location).to eq(root_url)
    end
  end
end
