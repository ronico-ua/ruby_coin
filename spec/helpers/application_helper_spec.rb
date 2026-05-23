# frozen_string_literal: true

require 'rails_helper'
require 'pagy/classes/request'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#pagy_bootstrap_nav' do
    it 'renders bootstrap navigation without raising NoMethodError or access error' do
      # Create a Pagy::Request using the helper's request object
      pagy_request = Pagy::Request.new(request: helper.request)
      pagy = Pagy::Offset.new(count: 100, page: 2, request: pagy_request)

      html = nil
      expect { html = helper.pagy_bootstrap_nav(pagy) }.not_to raise_error
      expect(html).to include('class="pagination"')
      expect(html).to include('pagy-bootstrap')
    end
  end
end
