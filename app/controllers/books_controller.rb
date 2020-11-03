class BooksController < ApplicationController
  before_action :authenticate_user!

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    redirect_to book_path(@book), notice: 'You have creatad book successfully.'
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end


  def show
    @book = Book.new
    @showbook = Book.find(params[:id])
    @user = @showbook.user
    @book_comment = BookComment.new
  end

  def index
    @book = Book.new
    @user = current_user
    @books = Book.all
  end

  def edit
    @user = current_user
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book), notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

 private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
