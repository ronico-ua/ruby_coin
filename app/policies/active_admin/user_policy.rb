# frozen_string_literal: true

module ActiveAdmin
  class UserPolicy < ApplicationPolicy
    def index?
      admin?
    end
    alias show? index?
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
end
