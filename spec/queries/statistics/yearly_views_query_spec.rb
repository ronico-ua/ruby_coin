# frozen_string_literal: true

require 'rails_helper'

describe Statistics::YearlyViewsQuery, type: :query do
  subject(:result) { described_class.new.count }

  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:ahoy_visit) { create(:ahoy_visit, user:) }
  let(:ahoy_event_properties) { { post_id: post.id } }
  let(:now) { Time.zone.local(2023, 8, 1, 15, 5) }

  context 'when there is no data' do
    it 'returns 0 views' do
      expect(result).to eq(0)
    end
  end

  context 'when data exis' do
    before do
      travel_to(now)
      create(:ahoy_event, visit_id: ahoy_visit.id, properties: ahoy_event_properties)
    end

    it 'returns correct number of view' do
      expect(result).to eq(1)
    end
  end

  context 'when data exist with different timestamps' do
    before do
      travel_to(now)
      create(:ahoy_event, visit_id: ahoy_visit.id, properties: ahoy_event_properties, time: now)
      create(:ahoy_event, visit_id: ahoy_visit.id, properties: ahoy_event_properties, time: 1.day.ago)
      create(:ahoy_event, visit_id: ahoy_visit.id, properties: ahoy_event_properties, time: 2.years.from_now)
      create(:ahoy_event, visit_id: ahoy_visit.id, properties: ahoy_event_properties,
                          time: Time.zone.local(2023, 12, 31, 23, 59))
    end

    it 'returns the correct number of yearly views' do
      expect(result).to eq(3)
    end
  end
end
