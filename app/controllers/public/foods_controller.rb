class Public::FoodsController < ApplicationController

  def index
    @foods = Food.all
  end

  def show
    @food = Food.find(params[:id])
  end

  def create
    @food = Food.new(food_params)
    @food.save
    redirect_back(fallback_location: root_path)
  end

  def edit
    @food = Food.find(params[:id])
  end

  def update
    @food = Food.find(params[:id])
    @food.update(food_params)
    redirect_to end_user_food_path(@food)
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to end_user_foods_path
  end

  def destroy_all
    @foods = current_end_user.foods
    @foods.destroy_all
    redirect_to end_user_foods_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :amount, :price)
  end

end
