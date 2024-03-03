# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::TagsController, type: :controller do
  render_views
  before do
    admin_user = create(:user, :admin)
    sign_in(admin_user)
  end

  context 'when display tags' do
    it 'new tag' do
      tag_name = 'New Tag'
      Tag.create(title: tag_name)
      get :index
      expect(response.body).to include('New Tag')
    end
  end
end
