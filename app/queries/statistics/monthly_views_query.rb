# frozen_string_literal: true

module Statistics
  class MonthlyViewsQuery < BaseQuery
    delegate :count, to: :all

    def all
      Ahoy::Event.where(time: Time.zone.today.all_month, name: 'Viewed Post')
    end
  end
end
