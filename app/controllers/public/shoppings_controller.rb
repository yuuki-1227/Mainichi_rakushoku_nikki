class Public::ShoppingsController < ApplicationController

  def index
    @shoppings = Shoppings.all
  end

  def show
    @shopping = Shoppings.find(params[:id])
  end

  def new
    @shopping = Shoppings.new
  end

  def create
    @shopping = Shoppings.new(shopping_params)
    @shopping.create
    redirect_to end_user_shoppings_path
  end

  def edit
    @shopping = Shoppings.find(params[:id])
  end

  def update
    @shopping = Shoppings.find(params[:id])
    @shopping.update(shopping_params)
    redirect_to end_user_shopping_path(@shopping)
  end

  def destroy
    @shopping = Shoppings.fing(params[:id])
    @shopping.destroy
    redirect_to end_user_shoppings_path
  end
  
end
