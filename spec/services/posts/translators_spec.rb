# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::Translator do
  let(:post) { create(:post) }
  let(:current_post) { post.translations.find_by(locale: 'en') }
  let!(:localization_params) do
    {
      'title_localizations' => { en: 'English Title' },
      'description_localizations' => { en: 'English Description' }
    }
  end

  let!(:updated_params) do
    {
      'title_localizations' => { en: 'Great Title' },
      'description_localizations' => { en: 'Great Description' }
    }
  end

  before do
    I18n.with_locale :uk do
      described_class.new(post, localization_params).call
    end
  end

  describe '#call' do
    it 'creates translations for available locales' do
      expect(post.translations.count).to eq(I18n.available_locales.count)
    end

    it 'sets the correct attributes in translations' do
      expect(current_post.title).to eq(localization_params.dig('title_localizations', :en))
      expect(current_post.description).to eq(localization_params.dig('description_localizations', :en))
    end
  end

  describe '#call with updated params' do
    before { described_class.new(post, updated_params).call }

    it 'updates translations for available locales' do
      expect(post.translations.count).to eq(I18n.available_locales.count)
    end

    it 'sets the correct attributes in translations' do
      expect(current_post.title).to eq(updated_params.dig('title_localizations', :en))
      expect(current_post.description).to eq(updated_params.dig('description_localizations', :en))
    end
  end
end
