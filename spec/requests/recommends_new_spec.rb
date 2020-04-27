require 'rails_helper'

RSpec.describe 'レコメンド作成ページのリクエストテスト', type: :request do
    let(:user) { create(:user) }
    let(:book) { create(:book) }

    context 'ユーザーがログインしていないとき' do
        it '302レスポンスが返されログイン画面に移行する' do
            get new_recommend_path
            expect(response.status).to eq 302
            expect(response).to redirect_to login_path
        end
    end

    context 'ユーザーがログインしているとき' do
        it 'レコメンド作成ページが返される' do
            log_in_by_post_request_as(user)
            get new_recommend_path
            expect(response.status).to eq 200
            expect(response).to render_template('recommends/new')
        end

        context 'user_idが渡された時' do
            it 'レコメンド作成ページが返される' do
                log_in_by_post_request_as(user)
            get new_recommend_path, params: { user_id: user.id }
            expect(response.status).to eq 200
            expect(response).to render_template('recommends/new')
            end
        end

        context 'book_idが渡された時' do
            it 'レコメンド作成ページが返される' do
                log_in_by_post_request_as(user)
            get new_recommend_path, params: { book_id: book.id }
            expect(response.status).to eq 200
            expect(response).to render_template('recommends/new')
            end
        end
    end
end