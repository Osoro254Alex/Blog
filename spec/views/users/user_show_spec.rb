require 'rails_helper'

RSpec.describe 'User Show', type: :feature do
  before :each do
    @user = User.create(name: 'Ellon', photo: 'https://picsum.photos/300/200', bio: 'Software Engineer from Nigeria', posts_counter: 12)
    @post1 = Post.create(author: @user, title: 'First_title', text: 'First text')
    @post2 = Post.create(author: @user, title: 'Second_title', text: 'Second text')
    @post3 = Post.create(author: @user, title: 'Third_title', text: 'Third text')
    visit user_path(@user.id)
  end
  it 'Show author name' do
    expect(page).to have_content(@user.name)
  end

  it 'Show  profile picture for each author' do
    expect(page).to have_css('img')
  end

  it 'Show  number of posts each author has written' do
    expect(page).to have_content(@user.posts_counter)
  end

  it 'Show  Bio of the user' do
    expect(page).to have_content(@user.bio)
  end

  it 'Show return of last three post of the user' do
    expect(page).to have_content(@post1.title)
    expect(page).to have_content(@post2.title)
    expect(page).to have_content(@post3.title)
  end

  it 'See all post button that allows to view all posts' do
    expect(page).to have_content('See all posts')
  end

  it "Redirect to user's post's show page when clicked" do
    click_link @post3.title
    expect(page).to have_current_path(user_post_path(@user, @post3))
  end

  it "Redirect to user's all post page when clicked" do
    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(@user))
  end
end
