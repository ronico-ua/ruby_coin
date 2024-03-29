# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag do
  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:posts) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end
end
