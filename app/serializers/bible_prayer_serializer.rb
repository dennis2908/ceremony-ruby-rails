class BiblePrayerSerializer < ActiveModel::Serializer
  attributes :id, :title, :verse, :summary, :scripture, :is_not_last, :is_not_first
end
