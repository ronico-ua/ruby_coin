# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def show?
    admin?
  end
end
