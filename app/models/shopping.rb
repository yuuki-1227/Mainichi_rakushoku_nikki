class Shopping < ApplicationRecord

  belongs_to :end_user
  has_many :foods

  attachment :image

end
