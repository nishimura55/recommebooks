require 'rails_helper'

RSpec.describe '本投稿ページのリクエストテスト', type: :request do
    let(:user) { create(:user) }
    let!(:admin_user) { create(:user, :admin_user) }
    let(:book) { create(:book) }

    context '一般ユーザーの場合' do
        it '処理を行えずトップページに移行される' do
            book.save
            log_in_by_post_request_as(user)
            expect do
                delete book_path(book)
                expect(response.status).to eq 302
            end.to change(Book, :count).by(0)
            expect(response).to redirect_to root_path
        end
    end

    context '管理ユーザーの場合' do
        it '本削除後本一覧ページに移行される' do
            book.save
            log_in_by_post_request_as(admin_user)
            expect do
                delete book_path(book)
                expect(response.status).to eq 302
            end.to change(Book, :count).by(-1)
            expect(response).to redirect_to books_path
        end
    end
end