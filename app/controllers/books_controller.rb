class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :not_error, only:[:edit, :update]
  def new
  	@book = Book.new
  end

  def create
  	# パラムスはデータの受け渡し時に必要
  	@book = Book.new(book_params)
  	@book.user_id = current_user.id
  	if @book.save
  		redirect_to book_path(@book.id), notice: "Book was successfully created."
  	else @books = Book.all
  		 @user = current_user
  		 render :index
  	end
  end


  def index
  	@books = Book.all
  	@book = Book.new
  	@user = current_user
  end

  def show
  	@book = Book.find(params[:id])
  	@user = current_user
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to book_path(@book), notice: "Book was successfully updated."
  	else render :edit
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path, notice: "Book was successfully destroyed."
  	
  end

  private
  def not_error
	@book = Book.find(params[:id])
	if current_user.id != @book.user_id
	   redirect_to books_path
	end
  end
  def book_params
  	params.require(:book).permit(:title, :body)
  end
end
