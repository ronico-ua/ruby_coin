# frozen_string_literal: true

require 'rails_helper'

POSTS_COLLECTIONS = {
  'all posts':      'Post.all',
  'active posts':   'Post.active',
  'inactive posts': 'Post.inactive'
}.freeze

TAGS_COLLECTIONS = {
  'all tags':   'Tag.pluck(:title)',
  'first tag':  'Tag.first.title',
  'last tag':   'Tag.last.title'
}.freeze

RSpec.describe Posts::Filter do
  let(:tags) { create_list(:tag, 2) }

  before do
    create_list(:post, 5, status: 'active', tag_ids: tags.pluck(:id))
    create_list(:post, 2, status: 'inactive', tag_ids: tags.pluck(:id))
    create_list(:post, 12, status: 'active')
    create_list(:post, 12, status: 'inactive')
  end

  describe '#call' do
    context 'when no filters are applied' do
      POSTS_COLLECTIONS.each do |name, post_collection|
        it "returns collection of #{name}" do
          expect(described_class.call(eval(post_collection), {}).count).to eq(eval(post_collection).count)
        end
      end
    end

    context 'when tags are selected' do
      POSTS_COLLECTIONS.each do |post, post_collection|
        TAGS_COLLECTIONS.each do |tag, tag_collection|
          it "returns collection of #{post} with #{tag}" do
            expect(described_class.call(eval(post_collection), { tags: eval(tag_collection) }).count)
              .to eq(eval(post_collection).joins(:tags).where(tags: { title: eval(tag_collection) }).distinct.count)
          end
        end
      end
    end

    context 'when tags are not exist' do
      it "returns 0 posts and doesn't fail" do
        expect(described_class.call(Post.all, { tags: 'nonexinstingtag' }).count).to eq(0)
      end
    end
  end
end
