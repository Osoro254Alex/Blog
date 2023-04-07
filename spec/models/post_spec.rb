require 'rails_helper'
RSpec.describe Post, type: :model do
  let(:author) { User.create(name: 'Alice') }
  let(:post) { Post.create(title: 'Post title', text: 'Post body', author:) }
  let(:comment1) { Comment.create(author:, post:, text: 'Comment body 1') }
  let(:comment2) { Comment.create(author:, post:, text: 'Comment body 2') }
  let(:like1) { Like.create(author:, post:) }
  let(:like2) { Like.create(author:, post:) }

  describe 'validations' do
    it 'validates presence of name' do
      post = Post.new(comments_counter: 0, likes_counter: 0)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it 'validates length of title' do
      post.title = 'a' * 251
      expect(post).not_to be_valid

      post.title = 'valid title'
      expect(post).to be_valid
    end

    it 'validates numericality of comments_counter' do
      post.likes_counter = 0
      post.comments_counter = 'not a number'
      expect(post).not_to be_valid
      expect(post.errors[:comments_counter]).to include('is not a number')

      post.comments_counter = -1
      expect(post).not_to be_valid
      expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')

      post.comments_counter = 0
      expect(post).to be_valid
    end

    it 'validates numericality of likes_counter' do
      post.comments_counter = 0
      post.likes_counter = 'not a number'
      expect(post).not_to be_valid
      expect(post.errors[:likes_counter]).to include('is not a number')

      post.likes_counter = -1
      expect(post).not_to be_valid
      expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')

      post.likes_counter = 0
      expect(post).to be_valid
    end
  end

  describe '#comments_counter' do
    it 'returns the number of comments' do
      expect(post.comments_counter).to eq(0)
      post.comments << comment1
      expect(post.comments_counter).to eq(1)
      post.comments << comment2
      expect(post.comments_counter).to eq(2)
    end
  end

  describe '#likes_counter' do
    it 'returns the number of likes' do
      expect(post.likes_counter).to eq(0)
      post.likes << like1
      expect(post.likes_counter).to eq(1)
      post.likes << like2
      expect(post.likes_counter).to eq(2)
    end
  end

  describe '#add_comment' do
    it 'adds a comment to the post' do
      post.add_comment(comment1)
      expect(post.comments).to include(comment1)
      expect(post.comments_counter).to eq(1)
    end
  end

  describe '#get_recent_comments' do
    it 'returns the most recent comments up to the given count' do
      post.comments << comment1
      post.comments << comment2
      expect(post.get_recent_comments(1)).to eq([comment2])
      expect(post.get_recent_comments(2)).to eq([comment2, comment1])
    end
  end

  describe '#update_author_posts_counter' do
    context 'when a post is saved' do
      it 'updates the posts counter of the associated author' do
        expect { post.save }.to change { author.reload.posts_counter }.by(1)
      end
    end
  end
end
