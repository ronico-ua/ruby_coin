# frozen_string_literal: true

module Statistics
  class PostViewsQuery < BaseQuery
    def count
      Ahoy::Event.where(name: 'Viewed Post').group(:properties).count
    end
  end
end
