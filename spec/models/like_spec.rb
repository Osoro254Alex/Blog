require 'rails_helper'
RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'Alice') }
  let(:post) { Post.create(title: 'Post', text: 'Post body', author: user) }

  describe 'callbacks' do
    describe '#update_post_likes_counter' do
      it 'updates the post likes counter' do
        @like = Like.create(author: user, post:)
        expect(post.reload.likes_counter).to eq(1)
      end
    end
  end

  describe '#update_post_likes_counter' do
    context 'when a like is created' do
      it 'updates the likes counter of the associated post' do
        like = Like.new(author: user, post:)
        expect { like.save }.to change { post.reload.likes_counter }.by(1)
      end
    end
  end
end
