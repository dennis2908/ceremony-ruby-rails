class GroupPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def leader?
    user == record.leader
  end

  def show?
    record.members.include?(user) || record.is_public
  end

  def join?
    record.leader != user && !record.members.include?(user)
  end

  def leave?
    record.leader != user && record.members.include?(user)
  end

end
