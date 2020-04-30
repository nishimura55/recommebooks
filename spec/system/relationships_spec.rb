require 'rails_helper'

RSpec.describe 'フォロー機能のシステムテスト', type: :system do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }
    let!(:book1) { create(:book, user: user1)}
    let!(:book2) { create(:book, user: user2)}
    let!(:book3) { create(:book, user: user3)}

    before do
        log_in_as(user1)
        visit user_path(user2)
        click_on 'フォローする'
    end

    describe 'フォローのテスト' do

        it 'フォローした内容がマイページに反映される' do
            visit user_path(user1)
            expect(page).to have_link book1.title, href: book_path(book1)
            expect(page).to have_link book2.title, href: book_path(book2)
            expect(page).not_to have_link book3.title, href: book_path(book3)
            click_on 'フォロー'
            expect(page).to have_link user2.name, href: user_path(user2)
        end

        it 'フォローされたユーザーの詳細ページに反映される' do
            visit user_path(user2)
            expect(page).to have_button 'フォロー解除'
            click_on 'フォロワー'
            expect(page).to have_link user1.name, href: user_path(user1)
        end
    end

    describe 'フォロー解除のテスト' do

        it 'フォローした解除した内容がマイページに反映される' do
            click_on 'フォロー解除'
            visit user_path(user1)
            expect(page).to have_link book1.title, href: book_path(book1)
            expect(page).not_to have_link book2.title, href: book_path(book2)
            expect(page).not_to have_link book3.title, href: book_path(book3)
            click_on 'フォロー'
            expect(page).not_to have_link user2.name, href: user_path(user2)
        end

        it 'フォローされたユーザーの詳細ページに反映される' do
            click_on 'フォロー解除'
            visit user_path(user2)
            expect(page).to have_button 'フォローする'
        end
    end

    describe 'フォロー通知のテスト' do
        it 'フォローの通知がされる' do
            log_out
            log_in_as(user2)
            visit notifications_path
            expect(page).to have_content user1.name
            expect(page).to have_content 'さんがあなたをフォローしました。'
        end
    end
    
end