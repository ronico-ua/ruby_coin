# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post do
  include_context 'when carrierwave cleanup'

  let(:post) { create(:post, status: 'active') }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_and_belong_to_many(:tags) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:status).with_values(active: 0, inactive: 1) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:subtitle) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:photo) }
  end

  describe 'photo uploader' do
    it 'has a photo uploader mounted' do
      expect(post.photo).to be_a(PhotoUploader)
    end

    it 'uploads a photo successfully' do
      image_path = Rails.root.join('spec', 'fixtures', 'files', 'test_image.png')
      post.update(photo: fixture_file_upload(image_path, 'image/png'))
      expect(post.photo).to be_present
    end
  end

  describe "updating post's photo" do
    it 'updates the cached profile image for post' do
      expect do
        post.update(photo: fixture_file_upload(
          'thumb_icon.png', 'image/png'
        ))
      end.to(change { post.reload.photo })
    end
  end

  describe 'similar_posts' do
    let(:similar_tag) { create(:tag) }
    let(:post) { create(:post, :active, tags: [similar_tag]) }

    context 'when similar_posts is active' do
      let(:similar_post) { create(:post, :active, tags: [similar_tag]) }

      it 'returns active posts with similar tags' do
        expect(described_class.similar_posts(post)).to include(similar_post)
      end
    end

    context 'when similar_posts is NOT active' do
      let(:similar_post) { create(:post, :inactive, tags: [similar_tag]) }

      it 'returns active posts with similar tags' do
        expect(described_class.similar_posts(post)).not_to include(similar_post)
      end
    end

    context 'when no similar posts' do
      it 'excludes the given post from the result' do
        expect(described_class.similar_posts(post)).not_to include(post)
      end
    end

    context 'when lots of similar posts' do
      let(:similar_posts) { Array.new(Post::LIMIT_COUNT + 1) { create(:post, :active, tags: [similar_tag]) } }

      it 'limits the result to LIMIT_COUNT' do
        similar_posts.each { |p| p.tags << similar_tag }
        expect(described_class.similar_posts(post).count).to eq(Post::LIMIT_COUNT)
      end
    end
  end

  describe '.ordered' do
    it 'orders posts by created_at in descending order' do
      post1 = create(:post, created_at: Time.current)
      post2 = create(:post, created_at: 1.hour.ago)
      post3 = create(:post, created_at: 2.hours.ago)

      expect(described_class.ordered).to eq([post1, post2, post3])
    end
  end
end
