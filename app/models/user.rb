class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy



  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :following_users, through: :followers, source: :followed
  has_many :follower_users, through: :followed, source: :follower

  def follow(user_id)
    followers.create(followed_id: user_id)
  end

  def unfollow(user_id)
    followers.find_by(followed_id: user_id).destroy
  end

  def self.looks(method,word)
    if search == "forward_match"
        @users = User.where("text LIKE?", "#{word}")
    elsif search == "backward_match"
        @users = User.where("text LIKE?", "%#{word}")
    elsif search == "perfect_match"
        @users = User.where("#{word}")
    elsif search == "partial_matdh"
        @users = User.where("text LIKE?", "%#{word}%")
    else
        @users = User.all
    end
  end


  def following?(user)
    following_users.include?(user)
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no-image-icon.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image-icon.jpg', content_type: 'image/jpeg')
    end
  profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
