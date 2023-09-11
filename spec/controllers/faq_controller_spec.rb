# frozen_string_literal: true

require 'rails_helper'

describe FaqController do
  describe 'GET #index' do
    let(:action) { :index }
    let(:params) { {} }

    it_behaves_like 'has http success'
  end
end
