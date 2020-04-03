require 'rails_helper'

RSpec.describe 'ユーザー削除のリクエストテスト', type: :request do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:admin_user) { create(:user, :admin_user) }

    context '一般ユーザーの場合' do
        it '処理を行えずトップページに移行される' do
            log_in_by_post_request_as(user)
            expect do
                delete user_path(other_user)
                expect(response.status).to eq 302
            end.to change(User, :count).by(0)
            expect(response).to redirect_to root_path
        end
    end

    context '管理ユーザーの場合' do
        it 'ユーザー削除後ユーザー一覧ページに移行される' do
            log_in_by_post_request_as(admin_user)
            expect do
                delete user_path(other_user)
                expect(response.status).to eq 302
            end.to change(User, :count).by(-1)
            expect(response).to redirect_to users_path
        end
    end

end