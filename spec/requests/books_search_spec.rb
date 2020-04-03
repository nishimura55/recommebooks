require 'rails_helper'

RSpec.describe '本検索ページのリクエストテスト', type: :request do
    let(:user) { create(:user) }

    context 'ユーザーがログインしていないとき' do
        it '302レスポンスが返されログイン画面に移行する' do
            get search_books_path(user)
            expect(response.status).to eq 302
            expect(response).to redirect_to login_path
        end
    end

    context 'ユーザーがログインしているとき' do
        it '本検索ページが返される' do
            log_in_by_post_request_as(user)
            get search_books_path(user)
            expect(response.status).to eq 200
            expect(response).to render_template('books/search')
        end
    end

end