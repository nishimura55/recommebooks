require 'rails_helper'

RSpec.describe 'つんどく機能のシステムテスト', type: :system do
    let(:favorite) { create(:favorite) }
    let(:user) { create(:user) }
    let(:book) { create(:book) }
    let!(:author) { create(:author) }

    describe 'つんどく登録のテスト' do

        before do
            log_in_as(user)
            book.save
        end

        context '本一覧ページからつんどく登録した場合' do
            it 'マイページでつんどく本の確認ができる' do
                visit books_path
                expect do
                    click_on 'つんどく本登録'
                    expect(page).to have_content 'つんどく本解除'
                end.to change {Favorite.count}.by(+1)
                visit user_path(user)
                click_on 'つんどく本'
                expect(page).to have_content '伝説の男の物語'
                expect(page).to have_content 'つんどく本解除'
            end
        end

        context '本詳細ページからつんどく登録した場合' do
            it 'マイページでつんどく本の確認ができる' do
                visit book_path(book)
                expect do
                    click_on 'つんどく本登録'
                    expect(page).to have_content 'つんどく本解除'
                end.to change {Favorite.count}.by(+1)
                visit user_path(user)
                click_on 'つんどく本'
                expect(page).to have_content '伝説の男の物語'
                expect(page).to have_content 'つんどく本解除'
            end
        end

        context 'マイページのタイムラインからつんどく登録した場合' do
            before do
                visit user_path(user)
                click_on '本を投稿'
                fill_in 'book_search', with: '山'
                click_on '本の題名を検索'
                page.all('#thmb-book-btn')[0].click
                fill_in '投稿者の感想', with: 'そうとう面白かった！'
                click_on '投稿する'
            end

            it 'マイページでつんどく本の確認ができる' do
                visit user_path(user)
                expect do
                    click_on 'つんどく本登録'
                    expect(page).to have_content 'つんどく本解除'
                end.to change {Favorite.count}.by(+1)
                visit user_path(user)
                click_on 'つんどく本'
                expect(page).to have_content '山'
                expect(page).to have_content 'つんどく本解除'
            end
        end

    end

    describe 'つんどく解除のテスト' do
        before do
            log_in_as(user)
            book.save
            visit books_path
            click_on 'つんどく本登録'
            visit user_path(user)
            click_on 'つんどく本'
            expect(page).to have_content 'つんどく本解除'
        end

        context '本一覧画面からつんどく本解除した場合' do
            it 'マイページのつんどく本タブから表示がなくなる' do
                visit books_path
                expect do
                    click_on 'つんどく本解除'
                    expect(page).to have_content 'つんどく本登録'
                end.to change {Favorite.count}.by(-1)
                visit user_path(user)
                click_on 'つんどく本'
                expect(page).not_to have_content 'つんどく本解除'
            end
        end

        context '本詳細画面からつんどく本解除した場合' do
            it 'マイページのつんどく本タブから表示がなくなる' do
                visit book_path(book)
                expect do
                    click_on 'つんどく本解除'
                    expect(page).to have_content 'つんどく本登録'
                end.to change {Favorite.count}.by(-1)
                visit user_path(user)
                click_on 'つんどく本'
                expect(page).not_to have_content 'つんどく本解除'
            end
        end

        context 'マイページからつんどく本解除した場合' do
            before do
                visit user_path(user)
                click_on '本を投稿'
                fill_in 'book_search', with: '山'
                click_on '本の題名を検索'
                page.all('#thmb-book-btn')[0].click
                fill_in '投稿者の感想', with: 'そうとう面白かった！'
                click_on '投稿する'
                click_on 'つんどく本登録'
            end

            it 'マイページのつんどく本タブから表示がなくなる' do
                visit user_path(user)
                click_on 'つんどく本'
                expect(page).to have_content 'つんどく本解除', count: 2
                visit user_path(user)
                expect do
                    click_on 'つんどく本解除'
                    expect(page).to have_content 'つんどく本登録'
                end.to change {Favorite.count}.by(-1)
                visit user_path(user)
                click_on 'つんどく本'
                expect(page).to have_content 'つんどく本解除', count: 1
            end
        end


    end

end