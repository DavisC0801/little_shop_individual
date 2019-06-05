class Dashboard::CouponsController < Dashboard::BaseController
  def index
    @coupons = current_user.coupons
  end

  def new
    if Coupon.max_limit?
      flash[:danger] = "Only 5 coupons can be present."
      redirect_to dashboard_coupons_path
    else
      @coupon = Coupon.new
    end
  end

  def create
    @coupon = current_user.coupons.new(coupon_params)
    if Coupon.max_limit?
      flash[:danger] = "Only 5 coupons can be present."
      redirect_to dashboard_coupons_path
    elsif @coupon.save
      flash[:success] = "A new coupon named #{@coupon.name} has been added."
      redirect_to dashboard_coupons_path
    else
      flash.now[:danger] = @coupon.errors.full_messages
      render :new
    end
  end

  def edit
    @coupon = Coupon.find(params[:id])
  end

  def update
    @coupon = Coupon.find(params[:id])
    if @coupon.update(coupon_params)
      flash[:success] = "The coupon #{@coupon.name} has been updated."
      redirect_to dashboard_coupons_path
    else
      flash[:danger] = @coupon.errors.full_messages
      @coupon = Coupon.find(params[:id])
      render :edit
    end
  end

  def destroy
    @coupon = Coupon.find(params[:id])
    if @coupon && @coupon.user == current_user
      if @coupon.used?
        flash[:error] = "Attempt to delete #{@coupon.nickname} was thwarted!"
      else
        flash[:success] = "The coupon #{@coupon.name} has been deleted."
        @coupon.destroy
      end
      redirect_to dashboard_coupons_path
    else
      render file: 'public/404', status: 404
    end
  end

  def enable
    @coupon = Coupon.find(params[:id])
    if @coupon.user == current_user
      toggle_active(@coupon, true)
      redirect_to dashboard_coupons_path
    else
      render file: 'public/404', status: 404
    end
  end

  def disable
    @coupon = Coupon.find(params[:id])
    if @coupon.user == current_user
      toggle_active(@coupon, false)
      redirect_to dashboard_coupons_path
    else
      render file: 'public/404', status: 404
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name, :value, :coupon_type)
  end

  def toggle_active(coupon, state)
    coupon.active = state
    coupon.save
  end
end
