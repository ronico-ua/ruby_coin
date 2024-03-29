# frozen_string_literal: true

module Ahoy
  class EventProcess < BaseService
    def initialize(ahoy, post, request)
      @ahoy = ahoy
      @post = post
      @request = request
    end

    def call
      process_ahoy
    end

    private

    def process_ahoy
      @ahoy.visit
      @ahoy.track 'Viewed Post', title: @post.title, post_id: @post.id, slug: @post.slug
      update_last_visit_timestamp
    end

    def update_last_visit_timestamp
      @request.session["last_visit_#{@post.id}"] = Time.zone.now.to_i
    end
  end
end
