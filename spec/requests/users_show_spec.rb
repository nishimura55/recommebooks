require 'rails_helper'

RSpec.describe 'ユーザー詳細ページのリクエストテスト', type: :request do
    let(:user) { create(:user) }
    let(:admin_user) { create(:user, :admin_user) }

    context 'ユーザーがログインしていないとき' do
        it 'ユーザー詳細ページが返される' do
            get user_path(user)
            expect(response.status).to eq 200
            expect(response).to render_template('users/show')
        end
    end

    context 'ユーザーがログインしているとき' do
        it 'ユーザー詳細ページが返される' do
            log_in_by_post_request_as(user)
            get user_path(user)
            expect(response.status).to eq 200
            expect(response).to render_template('users/show')
        end
    end

end