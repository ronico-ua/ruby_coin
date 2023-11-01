# frozen_string_literal: true

module Ahoy
  class VisitsValidator < BaseValidator
    attr_accessor :last_visit

    validate :first_visit_or_more_than_24_hours

    private

    def first_visit_or_more_than_24_hours
      return true if last_visit.nil?

      last_visit_time = Time.zone.at(last_visit)
      24.hours.ago >= last_visit_time
    end
  end
end
