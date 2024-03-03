# frozen_string_literal: true

shared_examples 'permit actions' do
  context 'when user can enter pages' do
    let(:user) { create(:user, role) }

    it { expect(policy).to permit_actions(actions) }
  end
end

shared_examples 'forbid actions' do
  context 'when user cant enter pages' do
    let(:user) { create(:user, role) }

    it { expect(policy).to forbid_actions(actions) }
  end
end
