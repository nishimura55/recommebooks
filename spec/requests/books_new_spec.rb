require 'rails_helper'

RSpec.describe '本投稿ページのリクエストテスト', type: :request do
    let(:user) { create(:user) }

    context 'ユーザーがログインしていないとき' do
        it '302レスポンスが返されログイン画面に移行する' do
            get new_book_path(user), params: { book: { rakuten_url: "https://www.rakuten.co.jp",
                                                       title: "テスト本",
                                                       story: "伝説の男の物語",
                                                       contributor_review: "稀代の名作",
                                                       author: "田中太郎" 
                                                      } 
                                              }
            expect(response.status).to eq 302
            expect(response).to redirect_to login_path
        end
    end

    context 'ユーザーがログインしているとき' do
        it '本投稿ページが返される' do
            log_in_by_post_request_as(user)
            get new_book_path(user), params: { book: { rakuten_url: "https://www.rakuten.co.jp",
                                               title: "テスト本",
                                               story: "伝説の男の物語",
                                               contributor_review: "稀代の名作",
                                               author: "田中太郎" 
                                              } 
                                      }
            expect(response.status).to eq 200
            expect(response).to render_template('books/new')
        end
    end

end