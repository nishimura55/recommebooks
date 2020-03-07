require 'rails_helper'

RSpec.describe 'ログイン・ログアウト機能のシステムテスト', type: :system do
    let!(:user) { create(:user) }

    describe 'ログインのテスト' do
    
        before do
            visit login_path
        end
    
        it 'ログインページが正しく表示される' do
            expect(page).to have_content 'ログイン'
            expect(page).to have_link 'こちらから新規登録', href: signup_path
        end
        
        context '入力内容が正しいユーザーの場合' do
            it '正常にログインできてヘッダーの項目に反映される' do
                expect(page).to have_link '新規登録', href: signup_path
                expect(page).to have_link 'ログイン', href: login_path
                fill_in 'メールアドレス', with: user.email
                fill_in 'パスワード', with: user.password
                click_button 'ログイン'
                expect(page).to have_content 'ログインしました'
                expect(page).to have_content user.name
                expect(page).not_to have_link '新規登録', href: signup_path
                expect(page).not_to have_link 'ログイン', href: login_path
                find(".dropdown-toggle").click
                expect(page).to have_link 'マイページ', href: user_path(user)
                expect(page).to have_link 'ログアウト', href: logout_path
            end
        end
    
        context '入力内容が無効なユーザーの場合' do
            it 'ログイン失敗となる' do
                fill_in 'メールアドレス', with: 'invalid_test@example.com'
                fill_in 'パスワード', with: 'invalid_password'
                click_button 'ログイン'
                expect(page).to have_content 'ログインに失敗しました'
                visit root_path
                expect(page).not_to have_content 'ログインに失敗しました'
            end
        end
    end

    describe 'ログアウトのテスト' do
        it 'ログインを行うとヘッダーの項目に反映される' do
            visit login_path
            fill_in 'メールアドレス', with: user.email
            fill_in 'パスワード', with: user.password
            click_button 'ログイン'
            find(".dropdown-toggle").click
            click_on 'ログアウト'
            expect(page).to have_content 'ログアウトしました'
            expect(page).to have_link '新規登録', href: signup_path
            expect(page).to have_link 'ログイン', href: login_path
        end
    end
    
end