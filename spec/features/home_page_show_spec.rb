# frozen_string_literal: true

require 'rails_helper'

describe 'Home show Page', type: :feature do
  let(:post) { create(:post, slug: SecureRandom.hex) }
  let(:main_post) { create(:post, main_post: true) }

  context 'when visiting a post page' do
    before { visit post_path(post) }

    it 'displays .post-show' do
      expect(page).to have_css('.post-show')
    end

    it 'displays .navigation' do
      expect(page).to have_css('.navigation')
    end

    it 'displays .post-main-img' do
      expect(page).to have_css('.post-main-img')
    end

    it 'displays .details-inner' do
      expect(page).to have_css('.details-inner')
    end

    it 'displays .post-show__content' do
      expect(page).to have_css('.post-show__content')
    end
  end

  context 'when similar posts exist' do
    let!(:post) { create(:post, title: 'Similar post') }
    let!(:tag_first) { create(:tag, title: 'tag1') }
    let!(:tag_second) { create(:tag, title: 'tag2') }
    let!(:similar_post_first) { create(:post, title: 'Similar Post 1') }
    let!(:similar_post_second) { create(:post, title: 'Similar Post 2') }
    let(:similar_posts) { [similar_post_first, similar_post_second] }

    before do
      post.tags << tag_first
      post.tags << tag_second
      similar_post_first.tags << tag_first
      similar_post_second.tags << tag_second

      visit post_path(post)
    end

    it 'displays block with similar posts' do
      expect(page).to have_css('.post-title.second', text: 'Схожі публікації')
    end

    it 'Display similar posts' do
      expect(page).to have_css('.post-column', count: similar_posts.count)
    end
  end

  context 'without similar posts block' do
    before do
      post = create(:post, title: 'Post with tag')
      tag_first = create(:tag, title: 'tag_first')
      tag_second = create(:tag, title: 'tag_second')
      post.tags << tag_first

      unrelated_post = create(:post, title: 'Another post')
      unrelated_post.tags << tag_second

      visit post_path(post)
    end

    it 'do not displays block with similar post' do
      expect(page).not_to have_css('.post-title.second', text: 'Схожі публікації')
    end
  end
end
