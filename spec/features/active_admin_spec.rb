# frozen_string_literal: true

require 'rails_helper'
# tags new?
# posts confirmed ?
RSpec.describe ActiveAdmin, type: :system do
  before do
    admin_user = create(:user, :admin_user)
    sign_in(admin_user)
  end

  context 'when no scope' do
    context 'when display users' do
      it 'new user' do
        user = create(:user)
        get '/admin/users'
        expect(response.body).to include(user.email)
      end
    end

    context 'when display tags' do
      it 'new tag' do
        # Створення нового тегу
        tag_name = 'New Tag'
        Tag.create(title: tag_name)
        get '/admin/tags'
        expect(response.body).to include('New Tag')
      end
    end

    context 'when display posts' do
      it 'active' do
        post = create(:post)
        get '/admin/posts'
        expect(response.body).to include(post.title)
        expect(response.body).to include(post.description)
        expect(response.body).to include(post.id.to_s)
      end

      it 'inactive' do
        post = create(:post, status: :inactive)
        get '/admin/posts'
        expect(response.body).to include(post.title)
        expect(response.body).to include(post.description)
        expect(response.body).to include(post.id.to_s)
      end

      it 'main' do
        post = create(:post, main_post: true)
        get '/admin/posts'
        expect(response.body).to include(post.title)
        expect(response.body).to include(post.description)
        expect(response.body).to include(post.id.to_s)
      end
    end
  end

  context 'when scope is activated' do
    let!(:main_post) { create(:post, main_post: true, title: 'mainPostTitle') }
    let!(:inactive_post) { create(:post, status: :inactive, title: 'inactivePostTitle') }
    let!(:simple_post) { create(:post, title: 'simplePostTitle') }
    let!(:user) { create(:user) }
    let!(:admin) { create(:user, role: :admin) }

    context 'when users show' do
      it 'scope all' do
        get '/admin/users', params: { scope: 'all' }
        expect(response.body).to include(user.email)
        expect(response.body).to include(admin.email)
        expect(response.body).to include('<td class="col col-role">user</td>')
        expect(response.body).to include('<td class="col col-role">admin</td>')
      end

      it 'admin' do
        get '/admin/users', params: { scope: 'admin' }
        expect(response.body).to include(admin.email)
        expect(response.body).to include('<td class="col col-role">admin</td>')
        expect(response.body).not_to include('<td class="col col-role">user</td>')
        expect(response.body).not_to include(user.email)
      end

      it 'scope user' do
        get '/admin/users', params: { scope: 'user' }
        expect(response.body).not_to include(admin.email)
        expect(response.body).not_to include('<td class="col col-role">admin</td>')
        expect(response.body).to include('<td class="col col-role">user</td>')
        expect(response.body).to include(user.email)
      end

      it 'scope moderator' do
        get '/admin/users', params: { scope: 'moderator' }
        expect(response.body).not_to include(admin.email)
        expect(response.body).not_to include('<td class="col col-role">admin</td>')
        expect(response.body).not_to include('<td class="col col-role">user</td>')
        expect(response.body).not_to include(user.email)
      end
    end

    context 'when posts show' do
      it 'scope all' do
        get '/admin/posts', params: { scope: 'all' }
        expect(response.body).to include(inactive_post.title)
        expect(response.body).to include(main_post.title)
        expect(response.body).to include(simple_post.title)
      end

      it 'scope main' do
        get '/admin/posts', params: { scope: 'main' }
        expect(response.body).to include(main_post.title)
        expect(response.body).not_to include(simple_post.title)
        expect(response.body).not_to include(inactive_post.title)
      end

      it 'scope active' do
        get '/admin/posts', params: { scope: 'active' }
        expect(response.body).to include(main_post.title)
        expect(response.body).to include(simple_post.title)
        expect(response.body).not_to include(inactive_post.title)
      end

      it 'scope inactive' do
        get '/admin/posts', params: { scope: 'inactive' }
        expect(response.body).not_to include(main_post.title)
        expect(response.body).not_to include(simple_post.title)
        expect(response.body).to include(inactive_post.title)
      end
    end
  end
end
