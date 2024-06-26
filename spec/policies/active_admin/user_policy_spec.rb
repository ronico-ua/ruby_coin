# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ActiveAdmin::UserPolicy do
  subject(:policy) { described_class.new(user, record) }

  describe '#index? && #confirm? && #show?' do
    let(:record) { create(:user) }
    let(:actions) { %i[index confirm show] }

    context 'when user is admin' do
      let(:role) { :admin }

      it_behaves_like 'permit actions'
    end

    context 'when user is moderator' do
      let(:role) { :moderator }

      it_behaves_like 'forbid actions'
    end

    context 'when user' do
      let(:role) { :user }

      it_behaves_like 'forbid actions'
    end
  end
end
