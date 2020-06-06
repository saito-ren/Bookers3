class UsersController < ApplicationController
before_action :authenticate_user!
before_action :not_error, only: [:edit, :update]

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new
  end

  def index
  	@users = User.all
  	@user = current_user
  	@book = Book.new
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to user_path(@user), notice: "User was successfully updated"
  	else render :edit
  	end
  end

  private
def not_error
	@user = User.find(params[:id])
	if current_user.id != @user.id
	   redirect_to user_path(current_user)
	end
end

  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
