class Friendship < ApplicationRecord
    validate :none_recursive
    validate :none_repeating, on: :create
  
    belongs_to :inviter, class_name: 'User'
    belongs_to :invitee, class_name: 'User'
  
    scope :accepted, -> { where(accepted: true) }
    scope :pending, -> { where(accepted: false) }
  
    private
  
    def none_recursive
      errors.add(:inviter, "You can't add yourself") if invitee == inviter
      errors.add(:invitee, "can't be missing") if invitee.nil?
      errors.add(:inviter, "can't be missing") if inviter.nil?
    end
  
    def none_repeating
      return unless inviter.friends_unfiltered.include?(invitee)
  
      errors.add(:inviter, "Request already sent")
    end
  end