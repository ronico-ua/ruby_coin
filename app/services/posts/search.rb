# frozen_string_literal: true

class Posts::Search < BaseService
  attr_accessor :params

  SEARCH = {
    all: 'search_everywhere',
    title: 'search_by_title',
    description: 'search_by_description'
  }.freeze

  def initialize(params)
    @params = params
  end

  def call
    return if params[:query].blank?

    Post.send(search_scope, params[:query])
  end

  def search_scope
    return SEARCH[:all] if params[:search_in].blank? || SEARCH.keys.to_s.exclude?(params[:search_in])

    SEARCH[params[:search_in].to_sym]
  end
end
