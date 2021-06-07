class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :shoppings, dependent: :destroy
  # foreign_key（FK）には、@user.xxxとした際に「@user.idがfollower_idなのかfollowed_idなのか」を指定します。
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # @user.booksのように、@user.yyyで、
  # そのユーザがフォローしている人orフォローされている人の一覧を出したい
  has_many :following_end_users, through: :followers, source: :followed
  # foreign_key（FK）には、@user.xxxとした際に「@user.idがfollower_idなのかfollowed_idなのか」を指定します。
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # @user.booksのように、@user.yyyで、
  # そのユーザがフォローしている人orフォローされている人の一覧を出したい
  has_many :follower_end_users, through: :followeds, source: :follower
  
  attachment :profile_image, destroy: false

  def following?(end_user)
    following_end_users.include?(end_user)
  end

  def follow(end_user_id)
    followers.create(followed_id: end_user_id)
  end

  def unfollow(end_user_id)
    followers.find_by(followed_id: end_user_id).destroy
  end
end
