class User < ApplicationRecord
  has_many :shares, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_one_attached :profile_photo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  enum :role, { user: 0, moderator: 1, admin: 2 }, default: :user

  def admin?
    role == "admin" || role == "moderator"
  end

  def symptoms_array
    symptoms.present? ? symptoms.split(",") : []
  end

  def symptoms_array=(array)
    self.symptoms = array.join(",") if array.present?
  end
end
