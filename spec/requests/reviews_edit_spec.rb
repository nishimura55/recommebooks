require 'rails_helper'

RSpec.describe 'レビュー編集のリクエストテスト', type: :request do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:book) { create(:book) }
    let(:review) { create(:review) }


    context 'ユーザーがログインしていないとき' do
        it 'ログイン画面に移行する' do
            review.save
            get edit_book_reviews_path(book.id)
            expect(response.status).to eq 302
            expect(response).to redirect_to login_path
        end
    end

    context '編集する投稿がないとき' do
        it 'トップページに移行する' do
            log_in_by_post_request_as(user)
            get edit_book_reviews_path(book.id)
            expect(response.status).to eq 302
            expect(response).to redirect_to root_path
        end
    end

    context 'ログインしていて編集するレビューがあるとき' do
        it 'レビュー編集ページが返される' do
            log_in_by_post_request_as(user)
            post book_reviews_path(book.id), params: { review: FactoryBot.attributes_for(:review) }
            get edit_book_reviews_path(book.id)
            expect(response.status).to eq 200
            expect(response).to render_template('reviews/edit')
        end
    end

    context '自分の投稿以外に対する編集をしようとしたとき' do
        it 'トップページに移行する' do
            log_in_by_post_request_as(user)
            post book_reviews_path(book.id), params: { review: FactoryBot.attributes_for(:review) }
            log_out_by_delete_request
            log_in_by_post_request_as(other_user)
            get edit_book_reviews_path(book.id)
            expect(response.status).to eq 302
            expect(response).to redirect_to root_path
        end
    end

end