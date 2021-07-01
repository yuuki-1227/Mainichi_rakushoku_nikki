class Tag < ApplicationRecord

  has_many :tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  # tag_mapsテーブルを通してpostテーブルを参照する
  has_many :posts, through: :tag_maps
  

end
