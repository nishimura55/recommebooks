require 'rails_helper'

RSpec.describe '本のジャンルのテスト', type: :model do
  let(:book_genre) { create(:book_genre) }
  let(:book) { create(:book) }
  let(:genre) { create(:genre) }

  describe 'バリデーションのテスト' do
    context 'バリデーションを通過した場合' do
      it '有効となる' do
        expect(book_genre).to be_valid
      end
    end

    context 'book_idがない場合' do
      it '無効となる' do
        book_genre.book_id = nil
        expect(book_genre.valid?).to eq(false)
      end
    end

    context 'genre_idがない場合' do
      it '無効となる' do
        book_genre.genre_id = nil
        expect(book_genre.valid?).to eq(false)
      end
    end

    context '本を削除した場合' do
      it '削除される' do
        book_genre.save
        expect(BookGenre.count).to eq(1)
        book_genre.book.destroy
        expect(BookGenre.count).to eq(0)
      end
    end

    context 'ジャンルを削除した場合' do
      it '削除される' do
        book_genre.save
        expect(BookGenre.count).to eq(1)
        book_genre.book.destroy
        expect(BookGenre.count).to eq(0)
      end
    end

  end
end
