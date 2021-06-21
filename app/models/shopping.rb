class Shopping < ApplicationRecord

  belongs_to :end_user
  has_many :foods, dependent: :destroy

  attachment :image

end
