# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ActiveAdmin::PagePolicy do
  subject(:policy) { described_class.new(user, record) }

  describe '#show?' do
    let(:actions) { %i[show] }

    context 'when record is Dashboard' do
      let(:record) { Struct.new(:name).new('Dashboard') }

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

    context 'when record is NOT Dashboard' do
      let(:record) { Struct.new(:name).new('...') }

      context 'when user is admin' do
        let(:role) { :admin }

        it_behaves_like 'forbid actions'
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
end
