class User < ApplicationRecord
  enum role: { general: 1, admin: 99 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :family_posts

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
