# frozen_string_literal: true

require 'rails_helper'
# tags new?
# posts confirmed ?
RSpec.describe Admin::PostsController, type: :controller do
  render_views
  before do
    admin_user = create(:user, :admin)
    sign_in(admin_user)
  end

  context 'when no scope' do
    it 'active' do
      post = create(:post)
      get :index
      expect(CGI.unescapeHTML(response.body)).to include(post.title)
      expect(CGI.unescapeHTML(response.body)).to include(post.description)
      expect(CGI.unescapeHTML(response.body)).to include(post.id.to_s)
    end

    it 'inactive' do
      post = create(:post, status: :inactive)
      get :index
      expect(CGI.unescapeHTML(response.body)).to include(post.title)
      expect(CGI.unescapeHTML(response.body)).to include(post.description)
      expect(CGI.unescapeHTML(response.body)).to include(post.id.to_s)
    end

    it 'main' do
      post = create(:post, main_post: true)
      get :index
      expect(CGI.unescapeHTML(response.body)).to include(post.title)
      expect(CGI.unescapeHTML(response.body)).to include(post.description)
      expect(CGI.unescapeHTML(response.body)).to include(post.id.to_s)
    end
  end

  context 'when scope' do
    let!(:main_post) { create(:post, main_post: true, title: 'mainPostTitle') }
    let!(:inactive_post) { create(:post, status: :inactive, title: 'inactivePostTitle') }
    let!(:simple_post) { create(:post, title: 'simplePostTitle') }

    it 'all' do
      get :index, params: { scope: 'all' }
      expect(CGI.unescapeHTML(response.body)).to include(inactive_post.title)
      expect(CGI.unescapeHTML(response.body)).to include(main_post.title)
      expect(CGI.unescapeHTML(response.body)).to include(simple_post.title)
    end

    it 'main' do
      get :index, params: { scope: 'main' }
      expect(CGI.unescapeHTML(response.body)).to include(main_post.title)
      expect(CGI.unescapeHTML(response.body)).not_to include(simple_post.title)
      expect(CGI.unescapeHTML(response.body)).not_to include(inactive_post.title)
    end

    it 'active' do
      get :index, params: { scope: 'active' }
      expect(CGI.unescapeHTML(response.body)).to include(main_post.title)
      expect(CGI.unescapeHTML(response.body)).to include(simple_post.title)
      expect(CGI.unescapeHTML(response.body)).not_to include(inactive_post.title)
    end

    it 'inactive' do
      get :index, params: { scope: 'inactive' }
      expect(CGI.unescapeHTML(response.body)).not_to include(main_post.title)
      expect(CGI.unescapeHTML(response.body)).not_to include(simple_post.title)
      expect(CGI.unescapeHTML(response.body)).to include(inactive_post.title)
    end
  end
end
