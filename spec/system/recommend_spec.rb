require 'rails_helper'

RSpec.describe 'レコメンド機能のシステムテスト', type: :system do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:book) { create(:book, user: user) }
    let(:recommend) { create(:recommend, recommender: user, recommended: other_user, book: book) }

    describe 'レコメンドのテスト' do
        it 'ホームページからレコメンドができる' do
            log_in_as(user)
            visit root_path
            expect do
                click_on 'レコメンドしてみる'
                click_on 'レコメンドする本を選ぶ'
                click_on 'レコメンドする'
                click_on 'レコメンドするユーザーを選ぶ'
                click_on 'レコメンドする'
                fill_in 'reco-message-field', with: 'とてもおすすめです！'
                click_on 'レコメンドする'
            end.to change {Recommend.count}.by(+1)
            expect(page).to have_content 'レコメンドが完了しました！'
            expect(page).to have_content other_user.name
            expect(page).to have_content book.title
        end

        it '本詳細ページからレコメンドができる' do
            log_in_as(user)
            visit book_path(book)
            expect do
                click_on 'レコメンドする'
                click_on 'レコメンドするユーザーを選ぶ'
                click_on 'レコメンドする'
                fill_in 'reco-message-field', with: 'とてもおすすめです！'
                click_on 'レコメンドする'
            end.to change {Recommend.count}.by(+1)
            expect(page).to have_content 'レコメンドが完了しました！'
            expect(page).to have_content other_user.name
            expect(page).to have_content book.title
        end

        it 'ユーザー詳細ページからレコメンドができる' do
            log_in_as(user)
            visit user_path(other_user)
            expect do
                click_on 'レコメンドする'
                click_on 'レコメンドする本を選ぶ'
                click_on 'レコメンドする'
                fill_in 'reco-message-field', with: 'とてもおすすめです！'
                click_on 'レコメンドする'
            end.to change {Recommend.count}.by(+1)
            expect(page).to have_content 'レコメンドが完了しました！'
            expect(page).to have_content other_user.name
            expect(page).to have_content book.title
        end
    end

    describe 'レコメンドの評価のテスト' do
        before do
            recommend.save
            log_in_as(other_user)
            visit user_recommends_path(other_user)
        end

        context '「面白かった！」評価の場合' do
            it 'レコメンドしたユーザーとレコメンドした本のポイントがたまる' do
                click_on 'レコメンドされた本'
                click_on '面白かった！'
                expect(page).to have_content 'レコメンドに対する回答を完了しました！'
                visit user_path(user)
                expect(page).to have_content '1レコメポイント'
                visit book_path(book)
                expect(page).to have_content '1レコメ評価ポイント'
            end
        end

        context '「合わなかったかも」評価の場合' do
            it 'レコメンドしたユーザーとレコメンドした本のポイントは加算されない' do
                click_on 'レコメンドされた本'
                click_on '合わなかったかも'
                expect(page).to have_content 'レコメンドに対する回答を完了しました！'
                visit user_path(user)
                expect(page).to have_content '0レコメポイント'
                visit book_path(book)
                expect(page).to have_content '0レコメ評価ポイント'
            end
        end

        context '「読んだことがある」評価の場合' do
            it 'レコメンドしたユーザーとレコメンドした本のポイントは加算されない' do
                click_on 'レコメンドされた本'
                click_on '読んだことがある'
                expect(page).to have_content 'レコメンドに対する回答を完了しました！'
                visit user_path(user)
                expect(page).to have_content '0レコメポイント'
                visit book_path(book)
                expect(page).to have_content '0レコメ評価ポイント'
            end
        end

    end
end