class PrayerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def author?
    user == record.author
  end

  def show?
    user == record.author || record.is_public
  end

  def show_comments?
    user == record.author || record.commenters.include?(user) || record.is_public
  end

end
