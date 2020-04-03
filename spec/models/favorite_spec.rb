require 'rails_helper'

RSpec.describe 'つんどくのテスト', type: :model do
  let(:favorite) { create(:favorite) }
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  describe 'バリデーションのテスト' do
    context 'バリデーションを通過した場合' do
      it '有効となる' do
        expect(favorite).to be_valid
      end
    end

    context 'user_idがない場合' do
      it '無効となる' do
        favorite.user_id = nil
        expect(favorite.valid?).to eq(false)
      end
    end

    context 'book_idがない場合' do
      it '無効となる' do
        favorite.book_id = nil
        expect(favorite.valid?).to eq(false)
      end
    end

    context 'ユーザーを削除した場合' do
      it 'そのユーザーのつんどくも削除される' do
        favorite.save
        expect(Favorite.count).to eq(1)
        favorite.user.destroy
        expect(Favorite.count).to eq(0)
      end
    end

    context '本を削除した場合' do
      it 'その本についたつんどくも削除される' do
        favorite.save
        expect(Favorite.count).to eq(1)
        favorite.book.destroy
        expect(Favorite.count).to eq(0)
      end
    end

  end


end
