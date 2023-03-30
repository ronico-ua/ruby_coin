# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post do
  include_context 'when carrierwave cleanup'

  let(:post) { create(:post) }

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
      # rubocop:enable Style/MethodCalledOnDoEndBlock
    end
  end
end
