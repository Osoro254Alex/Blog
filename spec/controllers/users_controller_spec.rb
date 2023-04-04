require 'rails_helper'

RSpec.describe '/users', type: :request do
  describe 'UsersConroller' do
    context 'GET index' do
      before(:example) do
        get '/users'
      end

      it 'Success response status for index action' do
        expect(response).to have_http_status(:success)
      end

      it 'Render correct templete for index action' do
        expect(response).to render_template(:index)
      end

      it 'Correct body placeholder text for index action' do
        expect(response.body).to include('This are Users')
      end
    end

    context 'GET show' do
      before(:example) do
        get '/users/1'
      end

      it 'Success response status for show action' do
        expect(response).to have_http_status(:success)
      end

      it 'Render correct templete for show action' do
        expect(response).to render_template(:show)
      end

      it 'Correct body placeholder text for show action' do
        expect(response.body).to include('This is a User')
      end
    end
  end
end
