require 'rails_helper'

RSpec.describe 'レビュー投稿のリクエストテスト', type: :request do
    let(:user) { create(:user) }
    let(:book) { create(:book) }
    let(:review) { create(:review) }

    context 'ユーザーがログインしていないとき' do
        it 'ログイン画面に移行する' do
            post book_reviews_path(book.id), params: { review: FactoryBot.attributes_for(:review)}
            expect(response.status).to eq 302
            expect(response).to redirect_to login_path
        end

        context 'パラメータが有効のとき' do
            it 'レビューが投稿され本詳細ページに移行する' do
                log_in_by_post_request_as(user)
                expect do
                  post book_reviews_path(book.id), params: { review: FactoryBot.attributes_for(:review) }
                  expect(response.status).to eq 302
                end.to change(Review, :count).by(1)
                follow_redirect!
                expect(response).to render_template('books/show')
                expect(response.body).to include '最高に面白かった'
            end
        end

        context 'パラメータが無効のとき' do
            it '本詳細ページが返される' do
                log_in_by_post_request_as(user)
                expect do
                  post book_reviews_path(book.id), params: { review: FactoryBot.attributes_for(:review, :invalid_review) }
                  expect(response.status).to eq 200
                end.to change(Review, :count).by(0)
                expect(response).to render_template('books/show')
            end
        end

    end
end