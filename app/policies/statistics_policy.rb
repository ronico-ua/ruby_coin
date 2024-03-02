# frozen_string_literal: true

class StatisticsPolicy < ApplicationPolicy
  def index?
    admin? || moderator?
  end
end
