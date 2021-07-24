class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :friends, through: :friendships, class_name: 'User'

  has_many :pending_friendships, -> { where status: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :pending_invitees, through: :pending_friendships, source: :friend

  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  validates :name, presence: true, length: { in: 3..20 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  def pending_invitees
    inverse_friendships.map { |friendship| friendship.user unless friendship.status }.compact
  end

  def pending_inviters
    friendships.map { |friendship| friendship.friend unless friendship.status }.compact
  end

  def accepted_friends
    friends - pending_inviters - pending_invitees
  end

  def not_acquaintances
    User.where.not(id: id) - friends
  end
end
