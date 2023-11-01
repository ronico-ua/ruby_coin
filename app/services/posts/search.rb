# frozen_string_literal: true

class Posts::Search < BaseService
  attr_accessor :params

  def initialize(params)
    @params = params
  end

  def call
    Post.search_everywhere(params[:query])
  end
end
