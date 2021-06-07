class Public::FoodsController < ApplicationController

  def index
    @foods = Food.all
  end

  def show
    @food = Food.find(params[:id])
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

end
