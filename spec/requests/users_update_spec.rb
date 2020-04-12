require 'rails_helper'

RSpec.describe 'ユーザー編集のリクエストテスト', type: :request do
    let(:user) { create(:user) }

    context 'ユーザーがログインしていない場合' do
        it 'ログインページに移行する' do
            user.save
            put user_path(user), params: { user: FactoryBot.attributes_for(:user, :update) }
            expect(response.status).to eq 302
            expect(response).to redirect_to login_path
        end
    end

    context 'パラメータが有効な場合' do
        it 'ユーザー詳細ページに移行し情報が更新される' do
            log_in_by_post_request_as(user)
            put user_path(user), params: { user: FactoryBot.attributes_for(:user, :update) }
            expect(response.status).to eq 302
            expect(response).to redirect_to user_path(user)
            follow_redirect!
            expect(response).to render_template('users/show')
            expect(response.body).to include "アップデイトユーザー"
        end
    end

    context 'パラメータが無効な場合' do
        it 'ユーザー編集ページが表示され情報が更新されない' do
            log_in_by_post_request_as(user)
            put user_path(user), params: { user: FactoryBot.attributes_for(:user, :invalid) }
            expect(response.status).to eq 200
            expect(response).to render_template('users/edit')
            expect(response.body).to include user.name
        end
    end

end