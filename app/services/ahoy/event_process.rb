# frozen_string_literal: true

module Ahoy
  class EventProcess
    def initialize(ahoy, post, request, remote_ip)
      @ahoy = ahoy
      @post = post
      @request = request
      @remote_ip = remote_ip
    end

    def process
      process_ahoy if first_visit_or_more_than_24_hours?
    end

    private

    def process_ahoy
      @ahoy.visit
      @ahoy.track 'Viewed Post', title: @post.title, post_id: @post.id
      update_last_visit_timestamp
    end

    def first_visit_or_more_than_24_hours?
      last_visit_timestamp = @request.session[:last_visit_timestamp]
      return true if last_visit_timestamp.nil?

      last_visit_time = Time.zone.at(last_visit_timestamp)
      24.hours.ago >= last_visit_time
    end

    def update_last_visit_timestamp
      @request.session[:last_visit_timestamp] = Time.zone.now.to_i
    end
  end
end
