class Post < ApplicationRecord

  belongs_to :end_user
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  # ランキング機能
  has_many :favorited_end_users, through: :favorites, source: :end_user
  has_many :commented_end_users, through: :post_comments, source: :end_user


  attachment :image

  enum three_meals:{
    "朝食":0, "昼食":1, "夕食":2
  }

  def favorited_by?(end_user)
    favorites.where(end_user_id: end_user.id).exists?
  end

end
