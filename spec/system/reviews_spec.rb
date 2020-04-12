require 'rails_helper'

RSpec.describe 'レビューのシステムテスト', type: :system do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:book) { create(:book) }
    let(:review) { create(:review) }

    describe 'レビューの投稿のテスト' do

        before do
            log_in_as(user)
            visit book_path(book)
        end

        context '正しく入力してレビューを投稿した場合' do
            it 'レビューが本詳細ページとマイページで表示される' do
                expect(page).not_to have_content 'あなたのレビュー'
                expect do
                    click_on 'レビューを投稿する'
                    fill_in 'タイトル', with: 'とてもためになった'
                    fill_in 'review-content', with: '万人にオススメしたい'
                    click_button '投稿'
                end.to change {Review.count}.by(+1)
                expect(page).to have_content 'レビューを投稿しました'
                expect(page).to have_content 'とてもためになった'
                expect(page).to have_content '万人にオススメしたい'
                expect(page).to have_content 'あなたのレビュー'
                visit user_path(user)
                click_on 'レビュー'
                expect(page).to have_content book.title
                expect(page).to have_content 'とてもためになった'
                expect(page).to have_content '万人にオススメしたい'
            end
        end

        context '無効な内容でレビューを投稿した場合' do
            it 'レビュー投稿に失敗する' do
                expect(page).not_to have_content 'あなたのレビュー'
                expect do
                    click_on 'レビューを投稿する'
                    fill_in 'タイトル', with: 'とてもためになった'
                    click_button '投稿'
                end.to change {Review.count}.by(0)
                expect(page).to have_content '投稿に失敗しました'
                click_on 'レビューを投稿する'
                expect(page).to have_content 'レビューを入力してください'
            end
        end
        
        context 'ネタバレをチェックしてレビューを投稿した場合' do
            it '他のユーザーから見るととボヤけてみえる' do
                expect(page).not_to have_content 'あなたのレビュー'
                expect do
                    click_on 'レビューを投稿する'
                    fill_in 'タイトル', with: 'とてもためになった'
                    fill_in 'review-content', with: 'ネタバレの内容です！犯人は●●！'
                    check 'spoiler-check'
                    click_button '投稿'
                end.to change {Review.count}.by(+1)
                expect(page).to have_content 'レビューを投稿しました'
                expect(page).to have_content 'とてもためになった'
                expect(page).to have_content 'ネタバレの内容です！犯人は●●！'
                expect(page).to have_content 'あなたのレビュー'
                expect(page).to have_content 'ネタバレ'
                log_out
                log_in_as(other_user)
                visit book_path(book)
                expect(page).to have_link user.name, href: user_path(user)
                expect(page).to have_content 'ネタバレ'
                expect(page).to have_selector '.spoiler-review', text: 'ネタバレの内容です！犯人は●●！'
            end
        end
    end

    describe 'レビューの編集のテスト' do

        before do
            log_in_as(user)
            visit book_path(book)
            click_on 'レビューを投稿する'
            fill_in 'タイトル', with: 'とてもためになった'
            fill_in 'review-content', with: '万人にオススメしたい'
            click_button '投稿'
        end

        context '正しく入力してレビューを編集した場合' do
            it '編集後のレビューが本詳細ページとマイページで表示される' do
                click_on '編集'
                fill_in 'タイトル', with: 'とても更新ためになった'
                fill_in 'review-content', with: '万人に更新オススメしたい'
                click_button '更新'
                expect(page).to have_content 'レビューを編集しました'
                expect(page).to have_content 'とても更新ためになった'
                expect(page).to have_content '万人に更新オススメしたい'
                expect(page).to have_content 'あなたのレビュー'
                visit user_path(user)
                click_on 'レビュー'
                expect(page).to have_content book.title
                expect(page).to have_content 'とても更新ためになった'
                expect(page).to have_content '万人に更新オススメしたい'
                expect(page).to have_link '編集', href: edit_book_reviews_path(book)
                expect(page).to have_link '削除', href: book_reviews_path(book)
            end
        end

        context 'レビューの中身を空欄にしてレビューを編集した場合' do
            it '編集に失敗する' do
                click_on '編集'
                fill_in 'タイトル', with: 'とても更新ためになった'
                fill_in 'review-content', with: ''
                click_button '更新'
                expect(page).to have_content '編集に失敗しました'
                expect(page).to have_content 'レビューを入力してください'
            end
        end

        context '自分以外の投稿の場合' do
            it '編集ボタンが表示されない' do
                log_out
                log_in_as(other_user)
                visit book_path(book)
                expect(page).not_to have_link '編集', href: edit_book_reviews_path(book)
            end
        end
    end

    describe 'レビューの削除のテスト' do

        before do
            log_in_as(user)
            visit book_path(book)
            click_on 'レビューを投稿する'
            fill_in 'タイトル', with: 'とてもためになった'
            fill_in 'review-content', with: '万人にオススメしたい'
            click_button '投稿'
        end

        context '自分の投稿の場合' do
            it '削除ができる' do
                expect do
                    click_on '削除'
                    page.accept_confirm
                    expect(page).to have_content '削除しました'
                end.to change {Review.count}.by(-1)
                expect(page).not_to have_content 'あなたのレビュー'
            end
        end

        context '自分以外の投稿の場合' do
            it '削除ボタンが表示されない' do
                log_out
                log_in_as(other_user)
                visit book_path(book)
                expect(page).not_to have_link '削除', href: book_reviews_path(book)
            end
        end
    end

end