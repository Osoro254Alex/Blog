require 'rails_helper'
RSpec.describe Post, type: :model do
  subject { Post.new(title: 'Python', text: 'Backend porgramming language', comments_counter: 10, likes_counter: 10) }
  before { subject.save }
  it 'The title should be present' do
    subject.title.nil?
    expect(subject).to_not be_valid
  end
  it 'The title length should not be exceed more than 250 characters' do
    subject.title = 'J' * 280
    expect(subject).to_not be_valid
  end
  it 'The comments_counter should be integer' do
    subject.comments_counter = 'b'
    expect(subject).to_not be_valid
  end
  it 'The comments_counter should be greater than or equal to zero' do
    subject.comments_counter = -8
    expect(subject).to_not be_valid
  end
  it ' Should test comments_counter to be >= 0' do
    expect(subject.comments_counter).to be >= 0
  end
  it 'The likes_counter should be integer' do
    subject.likes_counter = 'c'
    expect(subject).to_not be_valid
  end
  it 'The likes_counter should be greater than or equal to zero' do
    subject.likes_counter = 2.5
    expect(subject).to_not be_valid
  end
  it ' Should test likes_counter to be >= 0' do
    expect(subject.likes_counter).to be >= 0
  end
  it 'should diplay most recent comments' do
    subject.comments_counter = 5
    expect(subject.most_recent_comments).to eq(subject.comments.last(5))
  end
  it 'should display likes_counter' do
    subject.likes_counter = 6
    expect(subject.likes_counter).to eq(6)
  end
end
