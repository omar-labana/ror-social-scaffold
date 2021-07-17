class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :friendship_invitees, foreign_key: :inviter_id, class_name: 'Friendship'
  has_many :invitees, through: :friendship_invitees
  has_many :friendship_inviters, foreign_key: :invitee_id, class_name: 'Friendship'
  has_many :inviters, through: :friendship_inviters
end
