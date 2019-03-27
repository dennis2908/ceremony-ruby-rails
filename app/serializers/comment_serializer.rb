class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :prayer_id, :time
  belongs_to :commenter
  # belongs_to :commented_prayer
end
