class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @word = params[:word]
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:image], params[:search], params[:word])
    else
      @books = Book.looks(params[:image], params[:search], params[:word])
    end
  end

end
