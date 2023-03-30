require 'rails_helper'
RSpec.describe User, type: :model do
  subject { User.new(name: 'Alex', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Programmer', posts_counter: 4) }
  before { subject.save }
  it 'The name should not be balnk' do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  it 'The posts_counter should be integer' do
    subject.posts_counter = 'a'
    expect(subject).to_not be_valid
  end
  it 'The posts_counter should be greater than or equal to zero' do
    subject.posts_counter = -10
    expect(subject).to_not be_valid
  end
  it ' Should test posts_counter to be >= 0' do
    expect(subject.posts_counter).to be >= 0
  end
  it 'should display most recent posts' do
    subject.posts_counter = 4
    expect(subject.most_recent_posts).to eq(subject.posts.last(3))
  end
end
