# frozen_string_literal: true

module Statistics
  class DailyViewsQuery < BaseQuery
    delegate :count, to: :all

    def all
      Ahoy::Event.where(time: Time.zone.now.all_day, name: 'Viewed Post')
    end
  end
end
