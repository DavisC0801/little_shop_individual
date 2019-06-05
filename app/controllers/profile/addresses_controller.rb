class Profile::AddressesController < ApplicationController
  before_action :require_reguser

  def new
    @address = Address.new
  end

  def create
    @address = current_user.addresses.new(address_params)
    if @address.save
      flash[:success] = "A new address named #{@address.nickname} has been added."
      redirect_to profile_path
    else
      flash.now[:danger] = @address.errors.full_messages
      render :new
    end
  end

  def destroy
    @address = Address.find(params[:id])
    if @address && @address.user == current_user
      if @address.used?
        flash[:error] = "Attempt to delete #{@address.nickname} was thwarted!"
      else
        flash[:success] = "The address #{@address.nickname} has been deleted."
        @address.destroy
      end
      redirect_to profile_path
    else
      render file: 'public/404', status: 404
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:success] = "The address #{@address.nickname} has been updated."
      redirect_to profile_path
    else
      flash[:danger] = @item.errors.full_messages
      @address = Address.find(params[:id])
      render :edit
    end
  end

  private

  def address_params
    params.require(:address).permit(:nickname, :street, :city, :state, :zip)
  end
end
