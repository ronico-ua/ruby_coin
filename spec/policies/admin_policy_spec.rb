# frozen_string_literal: true

require 'rails_helper'
RSpec.describe AdminPolicy do
  subject(:policy) { described_class.new(user, record) }

  describe '#index? #confirm?' do
    let(:record) { create(:post) }
    let(:actions) { %i[index confirm] }

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
