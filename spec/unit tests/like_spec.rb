require 'rails_helper'
RSpec.describe Like do
  before :each do
    User.create(name: 'omar', email: 'omar@ramo.com',
                password: '123456789', password_confirmation: '123456789')

    Post.create(user_id: User.first.id,
                content: 'chicken are lovely')
  end

  describe 'like interaction and validations' do
    it 'user validation: exist?' do
      like = Like.new(user_id: 0, post_id: Post.first.id)
      expect(like.valid?).to eq(false)
    end

    it 'post validation: exist?' do
      like = Like.new(user_id: User.first.id, post_id: 0)
      expect(like.valid?).to eq(false)
    end

    it 'validates user and post' do
      like = Like.new(user_id: User.first.id, post_id: Post.first.id)
      expect(like.valid?).to eq(true)
    end
  end
end
