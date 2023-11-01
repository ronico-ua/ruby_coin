# frozen_string_literal: true

require 'rails_helper'

describe Statistics::PostViewsQuery, type: :query do
  subject(:result) { described_class.new.count }

  let(:user) { create(:user) }
  let(:ahoy_visit) { create(:ahoy_visit, user:) }

  context 'when data exist' do
    let(:post_first) { create(:post, id: 1) }
    let(:post_second) { create(:post, id: 2) }

    before do
      ahoy_visit1 = create(:ahoy_visit)
      ahoy_visit2 = create(:ahoy_visit)

      create(:ahoy_event, visit_id: ahoy_visit1.id, name: 'Viewed Post', properties: { post_id: post_first.id })
      create(:ahoy_event, visit_id: ahoy_visit2.id, name: 'Viewed Post', properties: { post_id: post_first.id })
      create(:ahoy_event, visit_id: ahoy_visit2.id, name: 'Viewed Post', properties: { post_id: post_second.id })
    end

    it 'returns the correct counts for each post' do
      result_full = {
        { 'post_id' => post_first.id } => 2,
        { 'post_id' => post_second.id } => 1
      }

      expect(result).to eq(result_full)
    end
  end

  context 'when there is no data' do
    it 'returns 0 views' do
      result_full = {}

      expect(result).to eq(result_full)
    end
  end
end
