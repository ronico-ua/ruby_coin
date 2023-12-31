# frozen_string_literal: true

module ActiveAdmin
  class PagePolicy < ApplicationPolicy
    def show?
      case record.name
      when 'Dashboard'
        admin?
      else
        false
      end
    end
  end
end
