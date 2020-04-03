require 'rails_helper'

RSpec.describe 'ユーザー編集ページのリクエストテスト', type: :request do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    context 'ユーザーがログインしていないとき' do
        it '302レスポンスが返されログイン画面に移行する' do
            get edit_user_path(user)
            expect(response.status).to eq 302
            expect(response).to redirect_to login_path
        end
    end

    context 'ユーザーがログインしているとき' do
        it 'ユーザー編集ページが返される' do
            log_in_by_post_request_as(user)
            get edit_user_path(user)
            expect(response.status).to eq 200
            expect(response).to render_template('users/edit')
        end
    end

    context '他のユーザーの編集ページのリクエストを送ったとき' do
        it '302レスポンスが返されホーム画面に移行する' do
            log_in_by_post_request_as(user)
            get edit_user_path(other_user)
            expect(response.status).to eq 302
            expect(response).to redirect_to root_path
        end
    end

end