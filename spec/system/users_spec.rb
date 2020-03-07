require 'rails_helper'

RSpec.describe 'ユーザーのシステムテスト', type: :system do

    describe 'ユーザーの新規登録のテスト' do

        before do
            visit root_path
            find(".navbar-toggler-icon").click
            click_on '新規登録'
        end

        it '新規登録ページが正しく表示される' do
            expect(page).to have_content '新規登録'
        end
        
        context '入力内容が正しいユーザーの場合' do
            it '正常に登録ができる' do
                expect do
                  fill_in 'ユーザー名', with: '新規テストユーザー'
                  fill_in 'メールアドレス', with: 'test@example.com'
                  fill_in 'パスワード', with: 'password'
                  fill_in 'パスワードの確認', with: 'password'
                  click_on '登録'
                end.to change {User.count}.by(+1)
                expect(page).to have_content 'ユーザー登録が完了しました。レコメブックスへようこそ！'
                expect(page).to have_content '新規テストユーザー'
                expect(page).to have_content '0レコメポイント'
            end
        end

        context '入力内容が無効なユーザーの場合' do
            it '登録失敗となる' do                
                  expect do
                  fill_in 'ユーザー名', with: '新規テストユーザー'
                  fill_in 'メールアドレス', with: 'test@example.com'
                  fill_in 'パスワード', with: 'password'
                  fill_in 'パスワードの確認', with: 'invalid_password'
                  click_on '登録'
                end.to change {User.count}.by(0)
                expect(page).to have_content 'パスワードの確認とパスワードの入力が一致しません'
            end
        end


    end



end