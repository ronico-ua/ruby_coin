# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::StatisticsController, type: :controller do
  describe 'GET #index' do
    it 'assigns @daily_views' do
      daily_views_query = instance_double(Statistics::DailyViewsQuery, count: 42)
      allow(Statistics::DailyViewsQuery).to receive(:new).and_return(daily_views_query)

      get :index

      expect(assigns(:daily_views)).to eq(42)
    end

    it 'assigns @monthly_views' do
      monthly_views_query = instance_double(Statistics::MonthlyViewsQuery, count: 100)
      allow(Statistics::MonthlyViewsQuery).to receive(:new).and_return(monthly_views_query)

      get :index

      expect(assigns(:monthly_views)).to eq(100)
    end

    it 'assigns @yearly_views' do
      yearly_views_query = instance_double(Statistics::YearlyViewsQuery, count: 1000)
      allow(Statistics::YearlyViewsQuery).to receive(:new).and_return(yearly_views_query)

      get :index

      expect(assigns(:yearly_views)).to eq(1000)
    end

    it 'assigns @total_views' do
      total_views_query = instance_double(Statistics::TotalViewsQuery, count: 10_000)
      allow(Statistics::TotalViewsQuery).to receive(:new).and_return(total_views_query)

      get :index

      expect(assigns(:total_views)).to eq(10_000)
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template('index')
    end
  end
end
