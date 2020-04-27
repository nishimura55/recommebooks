require 'rails_helper'

RSpec.describe 'レコメンド一覧のリクエストテスト', type: :request do
    let(:user) { create(:user) }
    let(:recommend) { create(:recommend) }

    context 'ユーザーがログインしていないとき' do
        it '302レスポンスが返されログイン画面に移行する' do
            recommend.save
            get user_recommends_path(user)
            expect(response.status).to eq 302
            expect(response).to redirect_to login_path
        end
    end

    context 'ユーザーがログインしているとき' do
        it 'レコメンド一覧ページが返される' do
            log_in_by_post_request_as(user)
            recommend.save
            get user_recommends_path(user)
            expect(response.status).to eq 200
            expect(response).to render_template('recommends/index')
        end
    end
end