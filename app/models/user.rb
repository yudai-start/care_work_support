class User < ApplicationRecord
  enum role: { general: 1, admin: 99 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :family_posts
  has_many :user_care_home_posts
  has_many :care_home_posts, through: :user_care_home_post

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
