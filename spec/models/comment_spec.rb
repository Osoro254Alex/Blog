require 'rails_helper'

RSpec.describe Comment, type: :model do
  before :each do
    @author = User.new(name: 'Alex',
                       photo: 'https://thumbs.dreamstime.com/z/professional-development-programmer-working-programming-website-software-coding-technology-writing-codes-data-code-132331729.jpg', bio: 'Full-Stack software developer')
    @post = Post.new(author_id: @author.id, title: 'Post for testing', text: 'This post is for test', comments_counter: 2)
    @comment1 = Comment.create(author_id: @author.id, post: @post, text: 'Test comment1')
    @comment2 = Comment.create(author_id: @author.id, post: @post, text: 'Test comment2')
  end
  it 'can not update comments counter when its a private method' do
    expect(@comment1).to respond_to(:update_comments_counter)
    expect(@comment2).to respond_to(:update_comments_counter)
  end
  it 'will have the post comments_counter through update_comments_counter' do
    expect(@post.comments_counter).to eq 2
  end
end
