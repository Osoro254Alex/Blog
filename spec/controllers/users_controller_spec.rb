require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let!(:user) { User.create(name: 'Tariq', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let!(:post) { Post.create(author: user, title: 'My First Post', text: 'Lorem ipsum') }
  describe 'GET #index' do
    it 'returns http success' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('Here is a list of users:')
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get user_path(user)
      expect(response.body).to include('Here are the details of a user:')
    end
  end
end
