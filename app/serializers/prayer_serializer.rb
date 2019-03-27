class PrayerSerializer < ActiveModel::Serializer
  attributes :id, :details, :overview, :author_id, :is_anonymous
  has_many :comments
end
