class Public::ShoppingsController < ApplicationController

  def index
    @shoppings = Shopping.all
  end

  def show
    @shopping = Shopping.find(params[:id])
  end

  def new
    @shopping = Shopping.new
  end

  def create
    @shopping = Shopping.new(shopping_params)
    @shopping.create
    redirect_to end_user_shoppings_path
  end

  def edit
    @shopping = Shopping.find(params[:id])
  end

  def update
    @shopping = Shopping.find(params[:id])
    @shopping.update(shopping_params)
    redirect_to end_user_shopping_path(@shopping)
  end

  def destroy
    @shopping = Shopping.fing(params[:id])
    @shopping.destroy
    redirect_to end_user_shoppings_path
  end

end
