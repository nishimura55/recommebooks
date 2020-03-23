require 'rails_helper'

RSpec.describe '本のシステムテスト', type: :system do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:admin_user) { create(:user, :admin_user) }

    describe '本一覧のテスト' do

        before do
            create_list(:book, 31)
            visit books_path
        end

        context '一般ユーザーの場合' do
            it '本一覧ページが表示される' do
                expect(page).to have_title '本一覧 | Recommebooks'
                expect(page).to have_selector '.pagination'
                Book.paginate(page: 1).each do |book|
                    expect(page).to have_link book.title, href: book_path(book)
                    expect(page).not_to have_link '削除', href: book_path(book)
                end
            end
        end

        context '管理ユーザーの場合' do
            it '削除リンクつきの本一覧ページが表示され本削除が可能' do
                log_in_as(admin_user)
                visit books_path
                expect(page).to have_title '本一覧 | Recommebooks'
                expect(page).to have_selector '.pagination'
                Book.paginate(page: 1).each do |book|
                    expect(page).to have_link book.title, href: book_path(book)
                    expect(page).to have_link '削除', href: book_path(book)
                end
                expect do
                  page.all('#delete-nallow')[0].click
                  page.accept_confirm
                  expect(page).to have_content '削除しました'
                end.to change {Book.count}.by(-1)
            end
        end

    end

    describe '本の投稿のテスト' do

        before do
            log_in_as(user)
            visit user_path(user)
            click_on '本を投稿'
        end

        it '本投稿ページが正しく表示される' do
            expect(page).to have_content '本を投稿'
            expect(page).to have_button '本の題名を検索'
        end

        context '正しく入力した場合' do 
            it '正常に投稿ができる' do
                expect do
                    fill_in 'book_search', with: '山'
                    click_on '本の題名を検索'
                    page.all('#thmb-book-btn')[0].click
                    fill_in '投稿者の感想', with: 'そうとう面白かった！'
                    click_on '投稿する'
                end.to change {Book.count}.by(+1)
                expect(page).to have_content '本を投稿しました'
                expect(page).to have_content '山'
                expect(page).to have_content 'そうとう面白かった！'
                expect(page).to have_content user.name
            end
        end

        context 'すでに投稿した本の場合' do
            it '投稿済みと表示される' do
                fill_in 'book_search', with: '山'
                click_on '本の題名を検索'
                page.all('#thmb-book-btn')[1].click
                fill_in '投稿者の感想', with: 'そうとう面白かった！'
                click_on '投稿する'
                visit user_path(user)
                click_on '本を投稿'
                fill_in 'book_search', with: '山'
                click_on '本の題名を検索'
                expect(page).to have_content '投稿済み'
            end
        end

        context '感想を入力しなかった場合' do 
            it '投稿失敗となる' do
                expect do
                    fill_in 'book_search', with: '山'
                    click_on '本の題名を検索'
                    page.all('#thmb-book-btn')[1].click
                    click_on '投稿する'
                end.to change {Book.count}.by(0)
                expect(page).to have_content '感想を入力してください'             
            end
        end

    end

end