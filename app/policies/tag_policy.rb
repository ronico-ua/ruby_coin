class TagPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def show?
    admin?
  end

  class Scope < Scope
    def resolve
      if user.present? && user.admin?
        scope.all
      else
        scope.where(status: 'active')
      end
    end
  end
end
