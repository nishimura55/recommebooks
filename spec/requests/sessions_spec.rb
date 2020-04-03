require 'rails_helper'

RSpec.describe 'ログインについてのリクエストテスト', type: :request do
    let!(:user) { create(:user) }

    describe 'ログインページ' do
        it '正常にログインページが返される' do
            get login_path
            expect(response.status).to eq 200
            expect(response).to render_template('sessions/new')
        end
    end

    describe 'ログイン' do
        before do
            get login_path
        end
        context '有効なパラメータの場合' do
            it 'ログイン後ユーザー詳細ページに移行する' do
                post login_path, params: { session: { email: user.email, password: user.password } }
                expect(response.status).to eq 302
                expect(response).to redirect_to user_path(user)
                follow_redirect!
                expect(response.body).to include 'ログインしました'
            end
        end

        context '無効なパラメータの場合' do
            it 'ログイン後ユーザー詳細ページに移行する' do
                post login_path, params: { session: { email: user.email, password: "invalid_password" } }
                expect(response.status).to eq 200
                expect(response).to render_template('sessions/new')
            end
        end
    end

    describe 'ログアウト' do
        
        context 'ログインしている場合' do
            it 'ログアウトできる' do
                log_in_by_post_request_as(user)
                delete logout_path
                expect(response.status).to eq 302
                follow_redirect!
                expect(response.body).to include 'ログアウトしました'
            end
        end

        context 'ログインしていない場合' do
            it '302レスポンスが返されログイン画面に移行する' do
                delete logout_path
                expect(response.status).to eq 302
                expect(response).to redirect_to login_path
            end
        end
    end
end