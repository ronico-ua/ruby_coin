# frozen_string_literal: true

module ActiveAdmin
  class UserPolicy < ApplicationPolicy
    def index?
      admin?
    end

    def show?
      admin?
    end

    def confirm?
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
end
