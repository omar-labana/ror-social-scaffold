class Friendship < ApplicationRecord
  validate :none_recursive
  validate :none_repeating, on: :create

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def self.safe_create(user_id, friend_id)
    transaction do
      create!(user_id: user_id,
              friend_id: friend_id, status: true)
      create!(user_id: friend_id,
              friend_id: user_id, status: false)
    end
  end

  def self.safe_delete(user_id, friend_id)
    transaction do
      find_by(user_id: user_id, friend_id: friend_id).delete
      find_by(user_id: friend_id, friend_id: user_id).delete
    end
  end

  private

  def none_recursive
    return unless user_id == friend_id

    errors.add(:user_id, "You can't add yourself")
  end

  def none_repeating
    return unless Friendship.find_by(user_id: user_id, friend_id: friend_id)

    errors.add(:user_id, 'Request already sent')
  end
end
