class UsersController < ApplicationController

  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @following_users = @user.following_users
    @follower_users = @user.follower_users
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
    @book_2days_ago = @books.created_2days_ago
    @book_3days_ago = @books.created_3days_ago
    @book_4days_ago = @books.created_4days_ago
    @book_5days_ago = @books.created_5days_ago
    @book_6days_ago = @books.created_6days_ago
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  def follows
    user = User.find(params[:id])
    @users = user.following_users
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_users
  end

  def search
    @user = User.find(params[:user_id])
    @books = @user.books.where(created_at: params[:created_at].to_date.all_day)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email.guest_user?
      redirect_to user_path(current_user), notice: 'ゲストユーザーはプロフィール編集へ移行できません。'
    end
  end
end
