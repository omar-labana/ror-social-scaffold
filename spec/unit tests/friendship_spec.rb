require 'rails_helper'

RSpec.describe Friendship do
  before(:each) do
    User.create(name: 'omar', email: 'omar@ramo.com',
                gravatar_url: 'dummy',
                password: '123456789', password_confirmation: '123456789')

    User.create(name: 'ramo', email: 'enio@example.com',
                gravatar_url: 'dummy',
                password: '123456789', password_confirmation: '123456789')
  end

  describe 'creation' do
    
    it 'valid association between two existing users' do
      friendship = Friendship.new(inviter_id: User.first.id, invitee_id: User.second.id, accepted: false)
      expect(friendship.valid?).to eq(true)
    end

    it 'validates alrady existing request' do
      Friendship.create(inviter_id: User.first.id, invitee_id: User.second.id, accepted: false)
      friendship = Friendship.new(inviter_id: User.second.id, invitee_id: User.first.id, accepted: false)
      expect(friendship.valid?).to eq(false)
    end

    it 'validates recursive relations' do
      friendship = Friendship.new(inviter_id: User.first.id, invitee_id: User.first.id, accepted: false)
      friendship.valid?
      expect(friendship.errors.full_messages).to eq(["Inviter can't ask themselves for friendship"])
    end
  end

  describe 'validates table for correct associations' do
    it 'updates a friendship to accept a friendship' do
      friendship = Friendship.create!(inviter_id: User.first.id, invitee_id: User.second.id, accepted: false)
      friendship.update(accepted: true)
      expect(friendship.accepted).to eq(true)
    end

  end
end


