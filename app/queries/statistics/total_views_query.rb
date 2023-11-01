# frozen_string_literal: true

module Statistics
  class TotalViewsQuery < BaseQuery
    delegate :count, to: :all

    def all
      Ahoy::Event.where(name: 'Viewed Post')
    end
  end
end
