class Profile::OrdersController < ApplicationController
  before_action :require_reguser

  def index
    @user = current_user
    @orders = current_user.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def destroy
    @order = Order.find(params[:id])
    if @order.user == current_user
      @order.order_items.where(fulfilled: true).each do |oi|
        item = Item.find(oi.item_id)
        item.inventory += oi.quantity
        item.save
        oi.fulfilled = false
        oi.save
      end

      @order.status = :cancelled
      @order.save

      redirect_to profile_orders_path
    else
      render file: 'public/404', status: 404
    end
  end

  def update
    @order = Order.find(params[:id])
    update_hash = {"address_id" => params[:address_id]}
    if @order.update(update_hash)
      flash[:success] = "The shipping address for order #{@order.id} has been updated."
      redirect_to profile_order_path(@order.id)
    else
      flash[:danger] = order.errors.full_messages
      render :show
    end
  end

  def create
    order = Order.create(user: current_user, status: :pending, address: Address.find(params[:format]))
    cart.items.each do |item, quantity|
      order.order_items.create(item: item, quantity: quantity, price: item.price)
    end
    session.delete(:cart)
    flash[:success] = "Your order has been created!"
    redirect_to profile_orders_path
  end
end
