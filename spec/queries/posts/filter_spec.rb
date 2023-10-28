# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::Filter do
  let!(:tags) { create_list(:tag, 2) }
  let!(:active_posts) { create_list(:post, 5, status: 'active', tag_ids: tags.first.id) }
  let!(:inactive_posts) { create_list(:post, 2, status: 'inactive', tag_ids: tags.last.id) }
  let!(:active_posts_without_tags) { create_list(:post, 2, status: 'active') }
  let!(:inactive_posts_without_tags) { create_list(:post, 2, status: 'inactive') }

  describe '#call' do
    context 'when no filters are applied' do
      it 'returns all posts' do
        posts = described_class.new(Post.all, params: {}).call

        expect(posts.count).to eq(
          active_posts.count +
          inactive_posts.count +
          active_posts_without_tags.count +
          inactive_posts_without_tags.count
        )
      end

      it 'returns all active posts' do
        posts = described_class.new(Post.active, params: {}).call

        expect(posts.count).to eq(active_posts.count + active_posts_without_tags.count)
      end

      it 'returns all inactive posts' do
        posts = described_class.new(Post.inactive, params: {}).call

        expect(posts.count).to eq(inactive_posts.count + inactive_posts_without_tags.count)
      end
    end

    context 'when tags are selected' do
      it 'returns all posts with all tags' do
        posts = described_class.new(Post.all, { tags: tags.pluck(:title) }).call

        expect(posts.count).to eq(active_posts.count + inactive_posts.count)
      end

      it 'returns all posts with first tag' do
        posts = described_class.new(Post.all, { tags: [tags.first.title] }).call

        expect(posts.count).to eq(active_posts.count)
      end

      it 'returns all posts with last tags' do
        posts = described_class.new(Post.all, { tags: [tags.last.title] }).call

        expect(posts.count).to eq(inactive_posts.count)
      end

      it 'returns all posts with no existent tag' do
        posts = described_class.new(Post.all, { tags: ['nonexistenttag'] }).call

        expect(posts.count).to eq(0)
      end
    end
  end
end
