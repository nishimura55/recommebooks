require 'rails_helper'

RSpec.describe 'レビューのテスト', type: :model do
  let(:review) { create(:review) }
  let(:other_review) { create(:review) }

  describe 'バリデーションのテスト' do
      context 'バリデーションを通過した場合' do
        it '有効となる' do
          expect(review).to be_valid
        end
      end
  
      context 'book_idがない場合' do
        it '無効となる' do
          review.book_id = nil
          expect(review.valid?).to eq(false)
        end
      end
  
      context 'user_idがない場合' do
        it '無効となる' do
          review.user_id = nil
          expect(review.valid?).to eq(false)
        end
      end

      context 'レビューの中身がない場合' do
        it '無効となる' do
          review.content = nil
          expect(review.valid?).to eq(false)
        end
      end

      context 'レビュータイトルが45文字を超えた場合' do
        it '登録ができない' do
          review.title = "a" * 46
          expect(review.valid?).to eq(false)
          expect(review.errors[:title]).to include("は45文字以内で入力してください")
        end
      end

      context 'レビュー内容が500文字を超えた場合' do
        it '登録ができない' do
          review.content = "a" * 501
          expect(review.valid?).to eq(false)
          expect(review.errors[:content]).to include("は500文字以内で入力してください")
        end
      end

      context 'ユーザーと本の組み合わせが一意でない場合' do
        it '登録ができない' do
          review.save
          other_review.user_id = review.user_id
          other_review.book_id = review.book_id
          expect(other_review.valid?).to eq(false)
        end
      end
  
      context 'お気に入りしたユーザーが削除された場合' do
        it '無効となる' do
          review.save
          expect(Review.count).to eq(1)
          review.user.destroy
          expect(Review.count).to eq(0)
        end
      end
  
      context 'お気に入りされている本が削除された場合' do
        it '無効となる' do
          review.save
          expect(Review.count).to eq(1)
          review.book.destroy
          expect(Review.count).to eq(0)
        end
      end
  end

end
