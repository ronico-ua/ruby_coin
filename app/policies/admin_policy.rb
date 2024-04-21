# frozen_string_literal: true

class AdminPolicy < ApplicationPolicy
  def index?
    admin?
  end
  alias confirm? index?

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
