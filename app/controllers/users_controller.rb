class UsersController < ApplicationController
  before_action :require_reguser, except: [:new, :create]

  def new
    @user = User.new
    @user.addresses.build if @user.addresses.empty?
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    @address = @user.addresses.new(address_params)
    if @user.save && @address.save
      session[:user_id] = @user.id
      flash[:success] = "Registration Successful! You are now logged in."
      redirect_to profile_path
    else
      User.last.destroy if User.last == @user
      Address.last.destroy if Address.last == @address
      flash.now[:danger] = @user.errors.full_messages + @address.errors.full_messages
      @user.update(email: "", password: "")
      render :new
    end
  end

  def update
    @user = current_user
    @user.update(user_update_params)
    @user.addresses.first.update(address_params)
    if @user.save && @user.addresses.first.save(address_params)
      flash[:success] = "Your profile has been updated"
      redirect_to profile_path
    else
      flash.now[:danger] = @user.errors.full_messages + @user.addresses.first.update(address_params)
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_update_params
    uup = user_params
    uup.delete(:password) if uup[:password].empty?
    uup.delete(:password_confirmation) if uup[:password_confirmation].empty?
    uup
  end

  def address_params
    params.require(:addresses).permit(:street, :city, :state, :zip)
  end
end
