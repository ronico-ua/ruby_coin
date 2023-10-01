# frozen_string_literal: true

require 'rails_helper'

describe 'Home Page' do
  it 'User visits the home page' do
    visit root_path
    expect(page).to have_selector('.home__container')
  end

  it 'displays .intro-block__content' do
    visit root_path
    expect(page).to have_selector('.intro-block__content')
  end

  it 'displays .accordion-category' do
    visit root_path
    expect(page).to have_selector('.accordion-category')
  end

  it 'displays .accordion-item' do
    visit root_path
    expect(page).to have_selector('.accordion-item')
  end

  it 'displays #collapseOne' do
    visit root_path
    expect(page).to have_selector('#collapseOne')
  end

  it 'displays .posts' do
    visit root_path
    expect(page).to have_selector('.posts')
  end

  it 'displays .post-column' do
    visit root_path
    expect(page).to have_selector('.post-column')
  end

  it 'displays .pagination__inner' do
    visit root_path
    expect(page).to have_selector('.pagination__inner')
  end
end
