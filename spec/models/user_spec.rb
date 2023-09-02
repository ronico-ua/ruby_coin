# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'associations' do
    it { is_expected.to have_many(:posts).dependent(:delete_all) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:role).with_values(admin: 0, moderator: 1, user: 2) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:avatar) }
    it { is_expected.to validate_presence_of(:encrypted_password) }

    it 'validates that :nickname is case-insensitively unique' do
      existing_user = build(:user, nickname: 'JohnDoe')
      new_user = build(:user, nickname: existing_user.nickname.upcase)
      expect(new_user).to be_valid
    end

    it 'validates that :email is case-insensitively unique' do
      existing_user = build(:user, email: 'something@gmail.com')
      new_user = build(:user, email: existing_user.email.upcase)
      expect(new_user).to be_valid
    end
  end
end
