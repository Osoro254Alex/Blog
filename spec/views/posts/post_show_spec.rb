require 'rails_helper'
RSpec.describe 'Post show page', type: :feature do
  before :each do
    @user1 = User.create(name: 'Ellon', photo: 'https://picsum.photos/300/300', bio: 'Software Engineer from Migingo')
    @user2 = User.create(name: 'Hassan', photo: 'https://picsum.photos/200/400', bio: 'Software Engineer from Uganda')
    @post1 = Post.create(author: @user1, title: 'Great', text: 'Hello World!')
    @post2 = Post.create(author: @user1, title: 'Howdy', text: 'This is test post.')
    Comment.create(author: @user1, post: @post1, text: 'Today is sunny and calm')
    Comment.create(author: @user1, post: @post1, text: 'Very good, lets go and Enjoy!')
    Like.create(author: @user1, post: @post1)
    Like.create(author: @user2, post: @post1)
    visit user_post_path(@user2, @post1)
  end
  it "show the post's title" do
    expect(page).to have_content(@post1.title)
  end
  it 'Show who wrote the post' do
    expect(page).to have_content(@post1.author.name)
  end
  it 'Show how many comments it has' do
    expect(page).to have_content("Comments: #{@post1.comments_counter}")
  end
  it 'Show how many likes it has' do
    expect(page).to have_content("Likes: #{@post1.likes_counter}")
  end
  it 'Show the post body' do
    expect(page).to have_content(@post1.text)
  end
  it 'Show the username of each commentor' do
    @post1.comments.each do |comment|
      expect(page).to have_content(comment.author.name)
    end
  end
  it 'Show the comment each commentor left' do
    @post1.comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end
end
