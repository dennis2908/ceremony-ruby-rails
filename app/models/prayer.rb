require 'pry'

class Prayer < ApplicationRecord
  validates :overview, presence: true
	
	has_many :group_prayers
  has_many :groups, through: :group_prayers
  
  has_many :comments
  has_many :commenters, through: :comments

  belongs_to :author, :class_name => "User"

  def self.all_public
    self.all.find_all{|prayer| prayer.is_public}.sort.reverse #collects and displays only public prayers
  end

  def group_ids=(group_ids)
    group_ids.delete("")
    group_ids.each do |group_id|
      self.groups << Group.find(group_id)
    end
    self.save
  end

  def all_comments
    self.comments.sort.reverse
  end

end
