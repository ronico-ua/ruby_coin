# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  subject { FactoryGirl::Syntax::Methods.build(:user) }

  describe 'associations' do
    it { is_expected.to have_many(:posts).dependent(:delete_all) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:role).with_values(admin: 0, moderator: 1, user: 2) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:nickname).on(:update) }
    it { is_expected.to validate_uniqueness_of(:nickname).case_insensitive.on(:update) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.told validate_uniqueness_of(:email).case_insensitive }
  end
end
