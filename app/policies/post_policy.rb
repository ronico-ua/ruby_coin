# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def show?
    admin?
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
