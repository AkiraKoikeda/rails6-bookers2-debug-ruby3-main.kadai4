class FavoritesController < ApplicationController

  def create
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).
      sort_by {|x|
        x.favorited_users.includes(:favorites).where(created_at: from...to).size
      }.reverse
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save

  end

  def destroy
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).
      sort_by {|x|
        x.favorited_users.includes(:favorites).where(created_at: from...to).size
      }.reverse
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
  end

end
