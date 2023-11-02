# frozen_string_literal: true

class Posts::Filter < BaseService
  attr_accessor :initial_scope, :params, :table_name

  def initialize(initial_scope, params, table_name)
    @initial_scope = initial_scope
    @params = params
    @table_name = table_name
  end

  def call
    scope = filter_by_translation(initial_scope)
    scope = ordered(scope)
    filter_by_tags(scope)
  end

  private

  def filter_by_translation(scope)
    scope.with_translation(table_name)
  end

  def ordered(scope)
    params[:order].present? ? scope.order(params[:order]) : scope.order(created_at: :desc)
  end

  def filter_by_tags(scope)
    return scope if params[:tags].nil?

    scope.joins(:tags).where(tags: { title: params[:tags] }).distinct
  end
end
