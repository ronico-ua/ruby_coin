# frozen_string_literal: true

class Management::PostPolicy < ApplicationPolicy
  def index?
    admin? || moderator?
  end

  def show?
    admin? || moderator?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end
end
