class Post < ApplicationRecord

  belongs_to :end_user
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  # tag_mapsテーブルを通してtagsテーブルを参照するように定義
  has_many :tags, through: :tag_maps

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

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?   # @postに紐づいているタグが存在する場合、タグの名前を配列として全て取得
    old_tags = current_tags - sent_tags                           # 現在取得した@postに存在するタグから、送信されてきたタグを除いたタグをold_tagsとする
    new_tags = sent_tags - current_tags                           # 送信されたタグから、現在存在するタグを除いたタグをnew_tagsとする

    old_tags.each do |old|
      self.post_tags.delete Tag.find_by(name: old)            # 古いタグを削除する
    end

    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)         # 新しいタグをデータベースに保存する
      self.post_tags << new_post_tag
    end
  end
end
