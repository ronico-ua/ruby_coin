# frozen_string_literal: true

module Admin
  class StatisticsController < ApplicationController
    def index
      @post_views = Statistics::PostViewsQuery.new.count
      @daily_views = Statistics::DailyViewsQuery.new.count
      @monthly_views = Statistics::MonthlyViewsQuery.new.count
      @yearly_views = Statistics::YearlyViewsQuery.new.count
      @total_views = Statistics::TotalViewsQuery.new.count
    end
  end
end
