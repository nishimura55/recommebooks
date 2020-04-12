require 'rails_helper'

RSpec.describe 'レビュー削除のリクエストテスト', type: :request do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:book) { create(:book) }
    let(:review) { create(:review) }

    context 'ユーザーがログインしていない場合' do
        it 'ログインページに移行する' do
            delete book_reviews_path(book.id)
            expect(response.status).to eq 302
            expect(response).to redirect_to login_path
        end
    end

    context '削除するレビューがない場合' do
        it 'トップページに移行する' do
            log_in_by_post_request_as(user)
            expect do
                delete book_reviews_path(book.id)
                expect(response.status).to eq 302
            end.to change(Review, :count).by(0)
            expect(response).to redirect_to root_path
        end
    end

    context 'ログインしていて削除するレビューがあるとき' do
        it '削除できる' do
            log_in_by_post_request_as(user)
            post book_reviews_path(book.id), params: { review: FactoryBot.attributes_for(:review) }
            expect do
                delete book_reviews_path(book.id)
                expect(response.status).to eq 302
            end.to change(Review, :count).by(-1)
            expect(response).to redirect_to book_path(book)
        end
    end

    context '他のユーザーのレビューを削除しようとしたとき' do
        it 'トップページに移行する' do
            log_in_by_post_request_as(user)
            post book_reviews_path(book.id), params: { review: FactoryBot.attributes_for(:review) }
            log_out_by_delete_request
            log_in_by_post_request_as(other_user)
            expect do
                delete book_reviews_path(book.id)
                expect(response.status).to eq 302
            end.to change(Review, :count).by(0)
            expect(response).to redirect_to root_path
        end
    end
end