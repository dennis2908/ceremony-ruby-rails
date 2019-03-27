class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook]

  validates :username, presence: true
  # validates :email, presence: true

  has_many :prayers, :foreign_key => "author_id"

	has_many :user_groups
	has_many :groups, through: :user_groups

  has_many :lead_groups, :foreign_key => "leader_id", :class_name => "Group"
  
  has_many :comments
  has_many :commented_prayers, through: :comments

  has_many :group_comments
  has_many :commented_groups, through: :group_comments

  def public_groups
    self.groups.find_all{|group|group.is_public}
  end

  def public_prayers
    self.prayers.find_all{|prayer|prayer.is_public && !prayer.is_anonymous}.sort.reverse
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.username = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  private
  
end
