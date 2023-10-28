# frozen_string_literal: true

module Statistics
  class YearlyViewsQuery < BaseQuery
    delegate :count, to: :all

    def all
      Ahoy::Event.where(time: Time.zone.today.all_year, name: 'Viewed Post')
    end
  end
end
