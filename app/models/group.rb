class Group < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :leader, presence: true
  
  has_many :user_groups
	has_many :members, through: :user_groups, :source => :group_member

	has_many :group_prayers
	has_many :prayers, through: :group_prayers

  belongs_to :leader, :class_name => "User"
  
  has_many :group_comments
  has_many :users, through: :group_comments

	def self.all_public
    self.all.find_all{|group| group.is_public}.sort.reverse #collects and displays only public groups
  end

  def show_prayers(user)
    if self.members.include?(user)
      self.prayers.sort.reverse
    else
      self.prayers.where(is_public: true).sort.reverse
    end
  end

  def all_group_comments
    self.group_comments.sort.reverse
  end
  
end
