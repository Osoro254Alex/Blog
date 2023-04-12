require 'rails_helper'

RSpec.describe 'User index', type: :feature do
  let!(:user) { User.create(name: 'Ellon', photo: 'https://picsum.photos/300/200', bio: 'Software Engineer from Nigeria', posts_counter: 12) }
  before do
    visit users_path
  end

  it 'Show author name' do
    expect(page).to have_content('Ellon')
  end

  it 'Show  profile picture for each author' do
    expect(page).to have_css('img')
  end

  it 'Show  number of posts each author has written' do
    expect(page).to have_content(user.posts_counter)
  end

  it "Redirect to user's show page when clicked" do
    click_link user.name
    expect(page).to have_current_path(user_path(user))
  end
end
