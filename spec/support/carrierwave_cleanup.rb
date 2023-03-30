# frozen_string_literal: true

RSpec.shared_context 'when carrierwave cleanup' do
  after do
    FileUtils.rm_rf(Rails.root.join('tmp', 'uploads'))
  end
end
