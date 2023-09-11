# frozen_string_literal: true

require 'rails_helper'

describe HomeController do
  describe 'GET #index' do
    let(:action) { :index }
    let(:params) { {} }

    it_behaves_like 'has http success'
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }
    let(:action) { :show }
    let(:params) { { id: post.id } }

    it_behaves_like 'has http success'
  end

  describe 'GET #search' do
    let(:action) { :search }
    let(:params) { {} }

    it_behaves_like 'has http success'
  end
end
