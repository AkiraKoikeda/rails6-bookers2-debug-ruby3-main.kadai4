class Group < ApplicationRecord
  has_many :users, through: :group_users
  belongs_to  :owner, class_name: 'User'
  has_many :group_users, dependent: :destroy

  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :group_image

  def is_owned_by?(user)
    owner.id == user.id
  end
end
