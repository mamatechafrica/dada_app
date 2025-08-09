class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Include SimpleDiscussion ForumUser functionality
  include SimpleDiscussion::ForumUser

  has_one :user_profile, dependent: :destroy
  
  enum :role, { guest: 'guest', member: 'member', moderator: 'moderator' }, default: 'member'
  
  after_create :create_user_profile
  
  def display_name
    user_profile&.anonymous_name || "Sister #{id}"
  end

  # Required by SimpleDiscussion - alias display_name to name
  alias_method :name, :display_name
  
  def onboarding_completed?
    user_profile&.completed_onboarding || false
  end
  
  private
  
  def create_user_profile
    UserProfile.create(user: self)
  end
end
