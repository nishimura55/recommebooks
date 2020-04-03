require 'rails_helper'

RSpec.describe 'お気に入りについてのリクエストテスト', type: :request do
    let(:user) { create(:user) }
    let(:book) { create(:book) }

    describe 'お気に入り登録' do
        context 'ログインしているとき' do
            it 'お気に入り登録できる' do
                book.save
                log_in_by_post_request_as(user)
                expect do
                    post book_favorites_path(book)
                end.to change(user.favorites, :count).by(1)
            end

            it 'Ajaxでお気に入り登録できる' do
                book.save
                log_in_by_post_request_as(user)
                expect do
                    post book_favorites_path(book), xhr: true
                end.to change(user.favorites, :count).by(1)
            end
        end

        context 'ログインしていないとき' do
            it 'お気に入り登録できずログイン画面に移行する' do
                book.save
                expect do
                    post book_favorites_path(book)
                end.to change(user.favorites, :count).by(0)
                expect(response).to redirect_to login_path
            end
        end
    end

    describe 'お気に入り解除' do
        before do
            book.save
            log_in_by_post_request_as(user)
            post book_favorites_path(book)
        end
        context 'ログインしているとき' do
            it 'お気に入り解除できる' do
                expect do
                    delete book_favorites_path(book)
                end.to change(user.favorites, :count).by(-1)
            end

            it 'Ajaxでお気に入り解除できる' do
                expect do
                    delete book_favorites_path(book), xhr: true
                end.to change(user.favorites, :count).by(-1)
            end
        end

        context 'ログインしていないとき' do
            it 'お気に入り登録できずログイン画面に移行する' do
                delete logout_path
                expect do
                    delete book_favorites_path(book)
                end.to change(user.favorites, :count).by(0)
                expect(response).to redirect_to login_path
            end
        end
    end
end