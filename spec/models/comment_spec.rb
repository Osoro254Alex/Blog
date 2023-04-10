require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'Alice') }
  let(:post) { Post.create(title: 'Post', text: 'Post body', author: user) }

  describe 'callbacks' do
    describe '#update_post_comments_counter' do
      it 'updates the post comments counter' do
        @comment = Comment.create(author: user, post:, text: 'Comment body')
        expect(post.reload.comments_counter).to eq(1)
      end
    end
  end

  describe '#update_post_comments_counter' do
    context 'when a comment is saved' do
      it 'updates the comments counter of the associated post' do
        comment = Comment.new(author: user, post:, text: 'Comment body')
        expect { comment.save }.to change { post.reload.comments_counter }.by(1)
      end
    end
  end
end
