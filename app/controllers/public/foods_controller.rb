class Public::FoodsController < ApplicationController

  # 一覧画面
  def index
    @foods = Food.all
  end

  # 詳細画面
  def show
    @food = Food.find(params[:id])
  end

  # 新規作成 及び 登録
  def create
    @food = Food.new(food_params)
    @shopping = Shopping.find(params[:shopping_id])
    @food.shopping_id = @shopping.id
    @food.save
    redirect_back(fallback_location: root_path)
  end

  # 編集画面
  def edit
    @food = Food.find(params[:id])
  end

  # 更新
  def update
    @food = Food.find(params[:id])
    @food.update(food_params)
    redirect_to end_user_shopping_path(current_end_user, @food.shopping_id)
  end

  # 削除
  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to end_user_shopping_path(current_end_user, @food.shopping_id)
  end


  private

  def food_params
    params.require(:food).permit(:name, :amount, :price)
  end

end
