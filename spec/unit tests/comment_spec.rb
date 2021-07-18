require 'rails_helper'
RSpec.describe Comment do
  before :each do
    User.create(name: 'omar', email: 'omar@maro.com',
                password: '123456789', password_confirmation: '123456789')
    Post.create(user_id: User.first.id,
                content: "chickens are very good")
  end

  describe 'create' do

    it 'comment validation full' do
      comment = Comment.new(user_id: User.first.id, post_id: Post.first.id,
                            content: 'Porttitor dignissim auctor litora Vivamus convallis hac. Aliquet. Id ac. Eros lobortis pharetra sociis diam donec, ridiculus ridiculus. Tellus aliquam. Porta mollis etiam nulla. Sit consequat, tristique vitae cras id faucibus. Mi faucibus nonummy auctor cras inceptos hymenaeos tempus faucibus duis netus suscipit fusce blandit cubilia sagittis posuere. Iaculis eu Dictumst integer. Nisi dolor vitae interdum hymenaeos gravida convallis sociosqu faucibus neque. Placerat hymenaeos duis lobortis aptent ligula malesuada augue consectetuer, sociosqu aliquet, sagittis ridiculus integer porttitor quam consequat lorem suspendisse. Aliquet natoque quis elit sit, vivamus, vel vel montes. Velit ultrices eget vulputate dapibus praesent vitae adipiscing. Vitae urna lectus. Molestie pulvinar Nam tellus semper eros nam netus enim elit mattis platea pharetra. Scelerisque sodales ac fusce placerat accumsan tristique in nulla. Conubia sagittis nostra fermentum vestibulum maecenas pulvinar pulvinar venenatis luctus est curabitur dolor suspendisse mus natoque lectus interdum. Eget hymenaeos habitasse Est. Donec imperdiet sociis. Ornare, faucibus pharetra tempus. Faucibus lacus auctor. Nonummy Mollis quam cum elit eu suscipit cum. Iaculis at mauris semper tincidunt lectus interdum elementum nibh, pharetra rhoncus dignissim amet, suscipit gravida penatibus Ac suscipit class in mus nullam, maecenas donec taciti aenean suspendisse tempor cum montes. Metus commodo iaculis mollis tempor sit in rhoncus mauris eu leo vestibulum ut accumsan morbi mattis. Morbi sociis iaculis commodo, augue litora bibendum non ornare. Tempor dictum torquent ante faucibus consectetuer ultricies iaculis elit. Curabitur. Ipsum senectus rutrum nisl in vehicula non imperdiet sociis fames sapien gravida Gravida sapien pharetra mollis urna torquent etiam penatibus tellus fermentum. Euismod ipsum ullamcorper fringilla ut morbi molestie ad tellus. Interdum primis curabitur nam ac. Justo enim vehicula, nullam luctus praesent taciti venenatis taciti felis mauris vestibulum odio, duis volutpat. Nulla eros ullamcorper est sagittis nonummy habitasse vulputate hac tempor. Torquent. Torquent. Sit nostra imperdiet purus maecenas. Cursus, nisl magna porttitor.')
      expect(comment.valid?).to eq(false)
    end

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
