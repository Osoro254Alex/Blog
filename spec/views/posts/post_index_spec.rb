require 'rails_helper'
RSpec.describe 'Posts index ', type: :feature do
  before do
    @user1 = User.create(name: 'Ellon', photo: 'https://picsum.photos/300/200', bio: 'Software Engineer from Migingo')
    @user2 = User.create(name: 'Hassan', photo: 'https://picsum.photos/200/300', bio: 'Software Engineer from Uganda')
    @post1 = Post.create(author: @user1, title: 'Great', text: 'Hello World!')
    @post2 = Post.create(author: @user1, title: 'Howdy', text: 'This is test post.')
    @comment1 = Comment.create(author: @user1, post: @post1, text: 'Today is sunny and calm')
    Comment.create(author: @user1, post: @post1, text: 'Very good, lets go and Enjoy!')
    visit user_posts_path(@user1)
  end
  it "displays user's profile picture" do
    expect(page).to have_css('img')
  end
  it "displays user's username" do
    expect(page).to have_content(@user1.name)
  end
  it 'displays number of posts the user has written' do
    expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
  end
  it "displays post's title" do
    expect(page).to have_content(@post1.title)
    expect(page).to have_content(@post2.title)
  end
  it "displays some of the post's body" do
    expect(page).to have_content(@post1.text)
    expect(page).to have_content(@post1.text)
  end
  it 'displays first comments on a post' do
    expect(page).to have_content(@comment1.author.name)
    expect(page).to have_content(@comment1.text)
  end
  it 'displays how many comments a post has' do
    expect(page).to have_content("Comments: #{@post2.comments_counter}")
    expect(page).to have_content("Comments: #{@post1.comments_counter}")
  end
  it 'displays how many likes a post has' do
    expect(page).to have_content("Likes: #{@post1.likes_counter}")
    expect(page).to have_content("Likes: #{@post1.likes_counter}")
  end
  it 'displays section for pagination if there are more posts than fit on the view' do
    expect(page).to have_css('.will-paginate-container ')
  end
  it "When I click on a post, it redirects me to that post's show page" do
    click_link('Howdy')
    expect(page).to have_current_path(user_post_path(@user1, @post2))
  end
end
