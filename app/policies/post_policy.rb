class PostPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def show?
    admin?
  end

  def update?
    user.present? && (user.admin? || record.user == user )
  end

  def destroy?
    user.present? && (user.admin? || record.user == user )
  end
end
