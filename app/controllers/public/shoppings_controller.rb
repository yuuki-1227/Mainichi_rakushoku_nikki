class Public::ShoppingsController < ApplicationController

  def index
    @shoppings = Shopping.all
  end

  def show
    @shopping = Shopping.find(params[:id])
    @food = Food.new
    @foods = Food.all
  end

  def new
    @shopping = Shopping.new
  end

  def create
    @shopping = Shopping.new(shopping_params)
    @shopping.end_user_id = current_end_user.id
    @shopping.save
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
    @shopping = Shopping.find(params[:id])
    @shopping.destroy
    redirect_to end_user_shoppings_path
  end

  private

  def shopping_params
    params.require(:shopping).permit(:buy_date, :total_price, :image)
  end

end
