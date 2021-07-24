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
      Friendship.safe_create(User.first.id, User.second.id)
      expect(User.first.friends).to eq([User.second])
    end

    it 'validates alrady existing request' do
      Friendship.safe_create(User.first.id, User.second.id)
      friendship = Friendship.new(user_id: User.second.id, friend_id: User.first.id, status: false)
      expect(friendship.valid?).to eq(false)
    end

    it 'validates recursive relations' do
      friendship = Friendship.new(user_id: User.first.id, friend_id: User.first.id, status: false)
      friendship.valid?
      expect(friendship.errors.full_messages).to eq(["User You can't add yourself"])
    end
  end

  describe 'validates table for correct associations' do
    it 'updates a friendship to accept a friendship' do
      Friendship.safe_create(User.first.id, User.second.id)
      friendship = Friendship.find_by(user_id: User.second.id, friend_id: User.first.id)
      friendship.update(status: true)
      expect(friendship.status).to eq(true)
    end
  end
end
