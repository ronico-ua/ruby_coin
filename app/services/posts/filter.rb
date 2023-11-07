# frozen_string_literal: true

class Posts::Filter < BaseService
  attr_accessor :initial_scope, :params

  def initialize(initial_scope, params)
    @initial_scope = initial_scope
    @params = params
  end

  def call
    scope = filter_by_translation(initial_scope)
    scope = ordered(scope)
    filter_by_tags(scope)
  end

  private

  def filter_by_translation(scope)
    scope.with_translation
  end

  def ordered(scope)
    params[:order].present? ? scope.order(params[:order]) : scope.order(created_at: :desc)
  end

  def filter_by_tags(scope)
    return scope if params[:tags].nil?

    scope.joins(:tags).where(tags: { title: params[:tags] }).distinct
  end
end