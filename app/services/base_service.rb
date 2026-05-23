# frozen_string_literal: true

class BaseService
  def self.call(*)
    service = new(*)

    service.__send__(:call) if service.respond_to?(:call)
  end

  private

  def call
    raise NotImplementedError
  end
end
