require 'rails_helper'
RSpec.describe Comment do
  before :each do
    User.create(name: 'omar', email: 'omar@maro.com',
                password: '123456789', password_confirmation: '123456789')
    Post.create(user_id: User.first.id,
                content: 'chickens are very good')
  end

  describe 'create' do
    it 'comment validation empty' do
      comment = Comment.new(user_id: User.first.id, post_id: Post.first.id, content: '')
      expect(comment.valid?).to eq(false)
    end

    it 'comment validation to user' do
      comment = Comment.new(user_id: 0, post_id: Post.first.id, content: 'Wow, great salad')
      expect(comment.valid?).to eq(false)
    end

    it 'comment validation created' do
      comment = Comment.new(user_id: User.first.id, post_id: Post.first.id,
                            content: 'Wow, great salad')
      expect(comment.valid?).to eq(true)
    end
  end
end
