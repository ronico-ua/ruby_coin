# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    FileUtils.rm_rf(Rails.root.join('tmp', 'uploads'))
    FileUtils.mkdir_p(Rails.root.join('tmp', 'uploads'))
  end

  config.after(:suite) do
    FileUtils.rm_rf(Rails.root.join('tmp', 'uploads'))
  end
end

# CarrierWave.configure do |config|
#   config.storage = :file
#   config.enable_processing = false
#   config.root = Rails.root.join('tmp', 'spec', 'uploads')

#   CarrierWave::Uploader::Base.descendants.each do |klass|
#     next if klass.anonymous?

#     klass.class_eval do
#       def cache_dir
#         Rails.root.join('tmp', 'spec', 'uploads', 'tmp')
#       end

#       def store_dir
#         Rails.root.join('tmp', 'spec', 'uploads', model.class.to_s.underscore.to_s, mounted_as.to_s, model.id.to_s)
#       end
#     end
#   end
# Update PhotoUploader to only process :thumb version
# end
