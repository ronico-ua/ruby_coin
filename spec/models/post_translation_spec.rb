# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostTranslation, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:post) }
  end

  describe 'creation' do
    let(:post) { create(:post) }

    it 'can be created with a post and valid attributes' do
      translation = described_class.new(
        post: post,
        locale: 'en',
        title: 'English Title',
        subtitle: 'English Subtitle',
        description: 'English Description'
      )

      expect(translation).to be_valid
      expect { translation.save! }.to change(described_class, :count).by(1)
    end
  end
end
