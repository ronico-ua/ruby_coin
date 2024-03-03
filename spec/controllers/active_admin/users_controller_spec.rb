# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  render_views
  before do
    admin_user = create(:user, :admin)
    sign_in(admin_user)
  end

  context 'when no scope' do
    let!(:user) { create(:user) }

    it 'new user' do
      get :index
      # pry
      expect(response.body).to include(user.email)
    end
  end

  context 'when scope is activated' do
    let!(:user) { create(:user) }
    let!(:admin) { create(:user, role: :admin) }

    context 'when users show' do
      it 'scope all' do
        get :index, params: { scope: 'all' }
        expect(response.body).to include(user.email)
        expect(response.body).to include(admin.email)
        expect(response.body).to include('<td class="col col-role">user</td>')
        expect(response.body).to include('<td class="col col-role">admin</td>')
      end

      it 'admin' do
        get :index, params: { scope: 'admin' }
        expect(response.body).to include(admin.email)
        expect(response.body).to include('<td class="col col-role">admin</td>')
        expect(response.body).not_to include('<td class="col col-role">user</td>')
        expect(response.body).not_to include(user.email)
      end

      it 'scope user' do
        get :index, params: { scope: 'user' }
        expect(response.body).not_to include(admin.email)
        expect(response.body).not_to include('<td class="col col-role">admin</td>')
        expect(response.body).to include('<td class="col col-role">user</td>')
        expect(response.body).to include(user.email)
      end

      it 'scope moderator' do
        get :index, params: { scope: 'moderator' }
        expect(response.body).not_to include(admin.email)
        expect(response.body).not_to include('<td class="col col-role">admin</td>')
        expect(response.body).not_to include('<td class="col col-role">user</td>')
        expect(response.body).not_to include(user.email)
      end
    end
  end
end
