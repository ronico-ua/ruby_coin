# frozen_string_literal: true

require 'rails_helper'

describe 'Home show Page', type: :feature do
  let(:post) { create(:post, slug: SecureRandom.hex) }
  let(:main_post) { create(:post, main_post: true) }

  context 'when visiting a post page' do
    before { visit post_path(post) }

    it 'displays .post-show' do
      expect(page).to have_selector('.post-show')
    end

    it 'displays .navigation' do
      expect(page).to have_selector('.navigation')
    end

    it 'displays .post-main-img' do
      expect(page).to have_selector('.post-main-img')
    end

    it 'displays .details-inner' do
      expect(page).to have_selector('.details-inner')
    end

    it 'displays .post-show__content' do
      expect(page).to have_selector('.post-show__content')
    end
  end
end
