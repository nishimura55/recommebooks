require 'rails_helper'

RSpec.describe 'ユーザー作成のリクエストテスト', type: :request do
    let!(:title) { create(:title, id: 1) }

    context 'パラメータが有効な場合' do
        it 'ユーザー詳細画面に移行する' do
            expect do
              post users_path, params: { user: FactoryBot.attributes_for(:user) }
              expect(response.status).to eq 302
            end.to change(User, :count).by(1)
            follow_redirect!
            expect(response).to render_template('users/show')
        end
    end

    context 'パラメータが無効な場合' do
        it 'ユーザー詳細画面に移行する' do
            expect do
              post users_path, params: { user: FactoryBot.attributes_for(:user, :invalid) }
              expect(response.status).to eq 200
            end.to change(User, :count).by(0)
            expect(response).to render_template('users/new')
        end
    end


end