class UsersController < ApplicationController
before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user =User.new(user_params)
    if @user.save
      flash[:notice]= "Welcome! You have signed up successfully."
      redirect_to root_path(@user.id)
    else
      render :new
    end
  end

  def create
    if @user.save
      flash[:success]= "Signed in successfully."
      redirect_to root_path(@user.id)
    else
      render :new
    end
  end

  def destroy
    flash[:notice] = 'Signed out successfully.'
    redirect_to root_path
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'You have updated user successfully.'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end


  def index
    @users = User.all
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    begin
    user = User.find(params[:id])

    rescue ActiveRecord::RecordNotFound
      redirect_to books_path
      return
    end

    unless user.id == current_user.id
      redirect_to books_path
    end
  end
end
