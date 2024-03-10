# frozen_string_literal: true

module ActiveAdmin
  class PagePolicy < ApplicationPolicy
    def show?
      return admin? if record.name == 'Dashboard'

      false
    end
  end
end
