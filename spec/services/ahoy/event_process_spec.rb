# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ahoy::EventProcess do
  subject(:result) { described_class.call(ahoy, post, request) }

  let(:post) { create(:post) }
  let(:request) { instance_double(ActionDispatch::Request, session: { last_visit: nil }) }
  let(:ahoy) { Ahoy::Tracker.new(visit_token: ahoy_visit.visitor_token) }
  let(:ahoy_visit) { build_stubbed(:ahoy_visit) }

  describe '#call' do
    it 'tracks a visit and an event' do
      expect(Ahoy::Visit.count).to eq(0)
      expect(Ahoy::Event.count).to eq(0)

      result

      expect(Ahoy::Visit.count).to eq(1)
      expect(Ahoy::Event.count).to eq(1)
    end
  end
end
