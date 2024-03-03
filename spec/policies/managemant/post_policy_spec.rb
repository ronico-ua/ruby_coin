# frozen_string_literal: true

require 'rails_helper'
require_relative '../../../app/policies/management/post_policy'
RSpec.describe Management::PostPolicy do
  subject(:policy) { described_class.new(user, record) }

  shared_examples 'permit' do
    context 'when user can enter pages' do
      let(:user) { create(:user, role) }

      it { expect(policy).to permit_actions(actions) }
    end
  end

  shared_examples 'forbid' do
    context 'when user cant enter pages' do
      let(:user) { create(:user, role) }

      it { expect(policy).to forbid_actions(actions) }
    end
  end

  describe '#index? #show?' do
    let(:record) { create(:post) }
    let(:actions) { %i[index show] }

    context 'when user is admin' do
      let(:role) { :admin }

      it_behaves_like 'permit'
    end

    context 'when user is moderator' do
      let(:user) { create(:user) }

      it { expect(policy).to forbid_actions(actions) }
    end
  end
end
