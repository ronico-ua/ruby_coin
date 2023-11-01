# frozen_string_literal: true

require 'rails_helper'

describe Statistics::TotalViewsQuery, type: :query do
  subject(:result) { described_class.new.count }

  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:ahoy_visit) { create(:ahoy_visit, user:) }
  let(:ahoy_event_properties) { { post_id: post.id } }
  let(:now) { Time.zone.now }

  context 'when there is no data' do
    it 'returns 0 views' do
      expect(result).to eq(0)
    end
  end

  context 'when data exist' do
    before do
      travel_to(now)
      create(:ahoy_event, visit_id: ahoy_visit.id, properties: ahoy_event_properties, time: now)
      create(:ahoy_event, visit_id: ahoy_visit.id, properties: ahoy_event_properties, time: 3.years.from_now)
      create(:ahoy_event, visit_id: ahoy_visit.id, properties: ahoy_event_properties, time: 2.years.ago)
    end

    it 'returns the correct number of views' do
      expect(result).to eq(3)
    end
  end
end
