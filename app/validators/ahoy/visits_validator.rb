# frozen_string_literal: true

module Ahoy
  class VisitsValidator < BaseValidator
    attr_accessor :last_visit_for_post

    validate :first_visit_or_more_than_24_hours

    private

    def first_visit_or_more_than_24_hours
      return if last_visit_for_post.nil?

      last_visit_time = Time.zone.at(last_visit_for_post)
      time_ago = 24.hours.ago

      return if last_visit_time < time_ago

      errors.add(:base, 'Visit not tracked - last visit within 24 hours')
    end
  end
end
