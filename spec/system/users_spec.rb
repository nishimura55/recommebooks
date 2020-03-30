require 'rails_helper'

RSpec.describe 'ユーザーのシステムテスト', type: :system do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:admin_user) { create(:user, :admin_user) }

    describe 'ユーザー一覧のテスト' do

        before do
            create_list(:user, 31)
            visit users_path
        end

        context '一般ユーザーの場合' do
            it 'ユーザー一覧ページが表示される' do
                expect(page).to have_title 'ユーザー一覧 | Recommebooks'
                expect(page).to have_selector '.pagination'
                User.order(created_at: "DESC").paginate(page: 1).each do |user|
                    expect(page).to have_link user.name, href: user_path(user)
                    expect(page).not_to have_link '削除', href: user_path(user)
                end
            end
        end

        context '管理ユーザーの場合' do
            it '削除リンクつきのユーザー一覧ページが表示されユーザー削除が可能' do
                log_in_as(admin_user)
                visit users_path
                expect(page).to have_title 'ユーザー一覧 | Recommebooks'
                expect(page).to have_selector '.pagination'
                expect(page).to have_link '削除'
                User.order(created_at: "DESC").paginate(page: 1).each do |user|
                    expect(page).to have_link user.name, href: user_path(user)
                end
                expect do
                  page.all('#delete-nallow')[0].click
                  page.accept_confirm
                  expect(page).to have_content '削除しました'
                end.to change {User.count}.by(-1)
            end
        end
    end

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

    describe 'ユーザーの編集のテスト' do

        before do
            log_in_as(user)
            visit user_path(user)
            click_on 'プロフィールの編集'
        end

        it 'プロフィール編集ページが正しく表示される' do
            expect(page).to have_content 'プロフィール編集'
            expect(page).to have_field 'ユーザー名', with: user.name
            expect(page).to have_field 'メールアドレス', with: user.email
        end

        context '有効な入力内容の場合' do
            it '正常に更新ができる' do
                attach_file 'ユーザー画像', "#{Rails.root}/spec/factories/test_image.jpg"
                fill_in '好きなジャンル・本', with: 'ミステリー系が好き'
                fill_in '自己紹介', with: '旅好きの大学生です'
                fill_in 'ユーザー名', with: 'Eテストユーザー'
                fill_in 'メールアドレス', with: 'Etest@example.com'
                click_button '更新する'
                expect(page).to have_selector("img[src$='test_image.jpg']")
                expect(page).to have_content 'プロフィールを更新しました'
                expect(page).to have_content 'ミステリー系が好き'
                expect(page).to have_content '旅好きの大学生です'
                expect(page).to have_content 'Eテストユーザー'
            end
        end

        context '無効な入力内容の場合' do
            context 'ユーザー名とメールアドレスが空欄の場合' do
                it '更新失敗となる' do
                    fill_in '好きなジャンル・本', with: 'ミステリー系が好き'
                    fill_in '自己紹介', with: '旅好きの大学生です'
                    fill_in 'ユーザー名', with: ''
                    fill_in 'メールアドレス', with: ''
                    click_button '更新する'
                    expect(page).to have_content 'ユーザー名を入力してください'
                    expect(page).to have_content 'メールアドレスを入力してください'
                    expect(page).to have_content 'メールアドレスは不正な値です'
                end
            end

            context 'パスワードとパスワードの確認が一致しない場合' do
                it '更新失敗となる' do
                    fill_in '好きなジャンル・本', with: 'ミステリー系が好き'
                    fill_in '自己紹介', with: '旅好きの大学生です'
                    fill_in 'ユーザー名', with: 'Eテストユーザー'
                    fill_in 'メールアドレス', with: 'Etest@example.com'
                    fill_in 'パスワード', with: 'Epassword'
                    fill_in 'パスワードの確認', with: 'invalid-Epassword'
                    click_button '更新する'
                    expect(page).to have_content 'パスワードの確認とパスワードの入力が一致しません'
                end
            end
        end

        context 'ログアウトしている状態でプロフィールを編集しようとした場合' do
            it 'ログインページに誘導され、ログインすると編集ページにとぶ（フレンドリーフォワーディング機能）' do
                log_out
                visit edit_user_path(user)
                expect(page).to have_content 'ログインが必要です'
                expect(page).to have_button 'ログイン'
                fill_in 'メールアドレス', with: user.email
                fill_in 'パスワード', with: user.password
                click_button 'ログイン'
                expect(page).to have_title 'プロフィール編集 | Recommebooks'
                expect(page).to have_content user.name
            end
        end

        context '別のユーザーのプロフィールを編集しようとした場合' do
            it '処理が拒絶されルートページにとばされる' do
                visit edit_user_path(other_user)
                expect(page).to have_content '無効な処理です'
                expect(page).to have_title 'ホーム | Recommebooks'
            end
        end
    end


end