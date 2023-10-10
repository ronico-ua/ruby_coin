# frozen_string_literal: true

require 'rails_helper'

describe 'Home Page', type: :feature do
  before do
    @main_post = create(:post, main_post: true)
    create_list(:post, 20)
    visit root_path
  end

  context 'when posts are present' do
    it 'displays .intro-block__content' do
      expect(page).to have_selector('.intro-block__content')
    end

    it 'displays .post-column' do
      expect(page).to have_selector('.post-column')
    end

    it 'displays .pagination__inner' do
      expect(page).to have_selector('.pagination__inner')
    end
  end

  it 'User visits the home page' do
    expect(page).to have_selector('.home__container')
  end

  it 'displays .accordion-category' do
    expect(page).to have_selector('.accordion-category')
  end

  it 'displays .accordion-item' do
    expect(page).to have_selector('.accordion-item')
  end

  it 'displays #collapseOne' do
    expect(page).to have_selector('#collapseOne')
  end

  it 'displays .posts' do
    expect(page).to have_selector('.posts')
  end
end
