# frozen_string_literal: true

module Ahoy
  class EventProcess < BaseService
    def initialize(ahoy, post, request, remote_ip)
      @ahoy = ahoy
      @post = post
      @request = request
      @remote_ip = remote_ip
    end

    def call
      process_ahoy
    end

    private

    def process_ahoy
      @ahoy.visit
      @ahoy.track 'Viewed Post', title: @post.title, post_id: @post.id
      update_last_visit_timestamp
    end

    def update_last_visit_timestamp
      @request.session[:last_visit] = Time.zone.now.to_i
    end
  end
end
