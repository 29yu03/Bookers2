class UsersController < ApplicationController
before_action :is_matching_login_user, only: [:edit, :update,]
before_action :set_user, only: [:show, :followings, :followers]

  def show
    @user = User.find(params[:id])
    @books = @user.books

    #現在ログインしているユーザーの全Entryデータを取得
    @currentUserEntry = Entry.where(user_id: current_user.id)
    #@userの全Entryデータを取得
    @userEntry = Entry.where(user_id: @user.id)

    #@user と current_user が別人の時
      #ログイン中のユーザーの全Entryデータを1つずつ取り出す
        #@userの全Entryデータを1つずつ取り出す
          #もし、ログイン中ユーザーのEntryデータの内、room_idが@userのEntryデータの持つroom_idと同じ時
            #ログイン中ユーザーと@userの共通のRoomが存在することを明確にする
            #@roomIdにログイン中のユーザーと@userの共通のroom_idを代入
      #もし、@isRoomが
      #falseの時
        #新しい Roomと Entryを作成

    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end

    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week

  end

  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
    end
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
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
    end
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

  def followings
    @users = @user.following
    render :followings
  end

  def followers
    @users = @user.followers
    render :followers
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
