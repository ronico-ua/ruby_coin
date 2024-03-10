# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Management::StatisticsController, type: :controller do
  context 'when admin' do
    before do
      admin_user = create(:user, :admin)
      sign_in(admin_user)

      daily_views_query = instance_double(Statistics::DailyViewsQuery, count: 42)
      monthly_views_query = instance_double(Statistics::MonthlyViewsQuery, count: 100)
      yearly_views_query = instance_double(Statistics::YearlyViewsQuery, count: 1000)
      total_views_query = instance_double(Statistics::TotalViewsQuery, count: 10_000)
      post_views_query = instance_double(Statistics::PostViewsQuery, count: 60)

      allow(Statistics::DailyViewsQuery).to receive(:new).and_return(daily_views_query)
      allow(Statistics::MonthlyViewsQuery).to receive(:new).and_return(monthly_views_query)
      allow(Statistics::YearlyViewsQuery).to receive(:new).and_return(yearly_views_query)
      allow(Statistics::TotalViewsQuery).to receive(:new).and_return(total_views_query)
      allow(Statistics::PostViewsQuery).to receive(:new).and_return(post_views_query)

      get :index
    end

    it 'assigns @post_views' do
      expect(assigns(:post_views)).to eq(60)
    end

    it 'assigns @daily_views' do
      expect(assigns(:daily_views)).to eq(42)
    end

    it 'assigns @monthly_views' do
      expect(assigns(:monthly_views)).to eq(100)
    end

    it 'assigns @yearly_views' do
      expect(assigns(:yearly_views)).to eq(1000)
    end

    it 'assigns @total_views' do
      expect(assigns(:total_views)).to eq(10_000)
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end
  end

  context 'when user' do
    before do
      user = create(:user)
      sign_in(user)

      get :index
    end

    it 'redirects to the root page' do
      expect(response).to redirect_to(root_path)
    end

    it 'sets a flash alert message' do
      expect(flash[:alert]).to be_present
    end
  end
end
