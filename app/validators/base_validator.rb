# frozen_string_literal: true

class BaseValidator
  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks
end
