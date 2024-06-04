# frozen_string_literal: true

class Posts::Filter < BaseService
  attr_accessor :scope, :params

  def initialize(scope, params)
    @scope = scope
    @params = params
  end

  def call
    filter_by_tags(scope_ordered)
  end

  private

  # немає сенсу використовувати scope.ordered, оскільки він вже включений в scope
  def new
    scope # scope.ordered
  end

  def best
    # приходить зі скоупом .active, який вже включає в себе .ordered
    scope.unscoped.best
  end

  def scope_ordered
    return scope if params[:order].presence == 'new'
    return scope unless params[:order].present? && Post::ORDER_TYPES.include?(params[:order])

    send(params[:order]) # фактично, на цьому етапі, можно залишити тільки -> best
  end

  def filter_by_tags(scope_ordered)
    return scope_ordered if params[:tag_ids].nil? || (params[:tag_ids].length == 1)

    scope_ordered.joins(:tags)
                 .where(tags: { id: params[:tag_ids] })
                 .distinct
  end
end
