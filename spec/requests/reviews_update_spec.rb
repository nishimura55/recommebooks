require 'rails_helper'

RSpec.describe 'レビュー更新のリクエストテスト', type: :request do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:book) { create(:book) }
    let(:review) { create(:review) }

    context 'ユーザーがログインしていない場合' do
        it 'ログインページに移行する' do
            put book_reviews_path(book.id), params: { review: FactoryBot.attributes_for(:review, :update_review) }
            expect(response.status).to eq 302
            expect(response).to redirect_to login_path
        end
    end

    context '編集する投稿がない場合' do
        it 'トップページに移行する' do
            log_in_by_post_request_as(user)
            put book_reviews_path(book.id), params: { review: FactoryBot.attributes_for(:review, :update_review) }
            expect(response.status).to eq 302
            expect(response).to redirect_to root_path
        end
    end

    context 'ログインしていて編集するレビューがあるとき' do
        it '編集ページが返される' do
            log_in_by_post_request_as(user)
            post book_reviews_path(book.id), params: { review: FactoryBot.attributes_for(:review) }
            put book_reviews_path(book.id), params: { review: FactoryBot.attributes_for(:review, :invalid_review) }
            expect(response.status).to eq 200
            expect(response).to render_template('reviews/edit')
        end
    end

    context '無効なパラメータのとき' do
        it 'レビュー編集ができる' do
            log_in_by_post_request_as(user)
            post book_reviews_path(book.id), params: { review: FactoryBot.attributes_for(:review) }
            put book_reviews_path(book.id), params: { review: FactoryBot.attributes_for(:review, :update_review) }
            expect(response.status).to eq 302
            expect(response).to redirect_to book_path(book)
            follow_redirect!
            expect(response).to render_template('books/show')
            expect(response.body).to include "アップデイト老若男女におすすめしたい稀代の名作"
        end
    end

    context '自分の投稿以外に対する編集をしようとしたとき' do
        it 'トップページに移行する' do
            log_in_by_post_request_as(user)
            post book_reviews_path(book.id), params: { review: FactoryBot.attributes_for(:review) }
            log_out_by_delete_request
            log_in_by_post_request_as(other_user)
            put book_reviews_path(book.id), params: { review: FactoryBot.attributes_for(:review, :update_review) }
            expect(response.status).to eq 302
            expect(response).to redirect_to root_path
        end
    end

end