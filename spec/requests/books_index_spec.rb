require 'rails_helper'

RSpec.describe '本投稿ページのリクエストテスト', type: :request do
    let(:user) { create(:user) }
    let(:admin_user) { create(:user, :admin_user) }
    let(:book) { create(:book) }

    context 'ユーザーがログインしていないとき' do
        it '本一覧ページが返される' do
            book.save
            get books_path
            expect(response.status).to eq 200
            expect(response).to render_template('books/index')
        end
    end

    context 'ユーザーがログインしているとき' do
        it 'ユーザー一覧ページが返される' do
            book.save
            log_in_by_post_request_as(user)
            get books_path
            expect(response.status).to eq 200
            expect(response).to render_template('books/index')
        end
    end

    context '管理ユーザーとしてログインしているとき' do
        it '削除表示のついた本一覧ページが返される' do
            book.save
            log_in_by_post_request_as(admin_user)
            get books_path
            expect(response.status).to eq 200
            expect(response).to render_template('books/index')
            expect(response.body).to include '削除'
        end
    end
end