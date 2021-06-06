class Post < ApplicationRecord

  belongs_to :user
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :foods


  def favorited_by?(end_user)
    favorites.where(end_user_id: end_user.id).exists?
  end

end
