require 'rails_helper'

RSpec.describe 'ユーザー一覧ページのリクエストテスト', type: :request do
    let(:user) { create(:user) }
    let(:admin_user) { create(:user, :admin_user) }

    context 'ユーザーがログインしていないとき' do
        it 'ユーザー一覧ページが返される' do
            user.save
            get users_path
            expect(response.status).to eq 200
            expect(response).to render_template('users/index')
        end
    end

    context 'ユーザーがログインしているとき' do
        it 'ユーザー一覧ページが返される' do
            log_in_by_post_request_as(user)
            get users_path
            expect(response.status).to eq 200
            expect(response).to render_template('users/index')
        end
    end

    context '管理ユーザーとしてログインしているとき' do
        it '削除表示のついたユーザー一覧ページが返される' do
            user.save
            log_in_by_post_request_as(admin_user)
            get users_path
            expect(response.status).to eq 200
            expect(response).to render_template('users/index')
            expect(response.body).to include '削除'
        end
    end



end