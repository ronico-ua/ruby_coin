# frozen_string_literal: true

require 'rails_helper'

xdescribe 'Home Page', type: :feature do
  before do
    @main_post = create(:post, main_post: true)
    create_list(:post, 20)
    visit root_path
  end

  context 'when posts are present' do
    it 'displays .intro-block__content' do
      expect(page).to have_css('.intro-block__content')
    end

    it 'displays .post-column' do
      expect(page).to have_css('.post-column')
    end

    it 'displays .pagination__inner' do
      expect(page).to have_css('.pagination__inner')
    end
  end

  context 'when posts aren`t present' do
    before do
      Post.delete_all
      visit root_path
    end

    it 'displays no main post content' do
      expect(page).not_to have_css('.intro-block__content')
    end

    it 'displays no posts' do
      expect(page).not_to have_css('.post-column')
    end

    it 'displays no pagination' do
      expect(page).not_to have_css('.pagination__inner')
    end
  end

  context 'when Checking CSS Selectors' do
    it 'User visits the home page' do
      expect(page).to have_css('.home__container')
    end

    it 'displays .accordion-category' do
      expect(page).to have_css('.accordion-category')
    end

    it 'displays .accordion-item' do
      expect(page).to have_css('.accordion-item')
    end

    it 'displays #collapseOne' do
      expect(page).to have_css('#collapseOne')
    end

    it 'displays .posts' do
      expect(page).to have_css('.posts')
    end
  end
end
