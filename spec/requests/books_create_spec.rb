require 'rails_helper'

RSpec.describe '本投稿ページのリクエストテスト', type: :request do
    let(:user) { create(:user) }
    let(:author) { create(:author) }
    let(:book) { create(:book) }

    context 'ユーザーがログインしていないとき' do
        it '302レスポンスが返されログイン画面に移行する' do
            post books_path, params: { book: { rakuten_url: "https://www.rakuten.co.jp",
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

    context 'パラメータが有効のとき' do
        it '本が投稿され本詳細ページに移行する' do
            log_in_by_post_request_as(user)
            expect do
              post books_path, params: { book: { rakuten_url: "https://www.rakuten.co.jp",
                                                 title: "テスト本",
                                                 story: "伝説の男の物語",
                                                 contributor_review: "稀代の名作",
                                                 author: "田中太郎" 
                                                } 
                                        }
              expect(response.status).to eq 302
            end.to change(Book, :count).by(1)
            follow_redirect!
            expect(response).to render_template('books/show')
            expect(response.body).to include 'テスト本'
        end
    end

    context 'パラメータが無効のとき' do
        it '本投稿ページが返される' do
            log_in_by_post_request_as(user)
            expect do
              post books_path, params: { book: { rakuten_url: "",
                                                 title: "テスト本",
                                                 story: "伝説の男の物語",
                                                 contributor_review: "稀代の名作",
                                                 author: "田中太郎" 
                                                } 
                                        }
              expect(response.status).to eq 200
            end.to change(Book, :count).by(0)
            expect(response).to render_template('books/new')
        end
    end

end