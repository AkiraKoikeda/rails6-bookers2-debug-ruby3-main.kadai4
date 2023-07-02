class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :title, presence:true
  validates :body, presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.looks(method,word)
    if search == "forward_match"
        @books = Book.where("text LIKE?", "#{word}")
    elsif search == "backward_match"
        @books = Book.where("text LIKE?", "%#{word}")
    elsif search == "perfect_match"
        @books = Book.where("#{word}")
    elsif search == "partial_matdh"
        @books = Book.where("text LIKE?", "%#{word}%")
    else
        @books = Book.all
    end
  end

end
