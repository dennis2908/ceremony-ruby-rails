class GroupComment < ApplicationRecord

  validates :content, presence: true

  belongs_to :commented_group, :class_name => "Group", :foreign_key => "group_id"
  belongs_to :commenter, :class_name=> "User", :foreign_key => "user_id"

end