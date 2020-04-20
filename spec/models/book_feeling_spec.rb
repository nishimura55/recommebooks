require 'rails_helper'

RSpec.describe 'どんな時にのテスト', type: :model do
  let(:book_feeling) { create(:book_feeling) }
  let(:book) { create(:book) }
  let(:feeling) { create(:feeling) }

  describe 'バリデーションのテスト' do
    context 'バリデーションを通過した場合' do
      it '有効となる' do
        expect(book_feeling).to be_valid
      end
    end

    context 'book_idがない場合' do
      it '無効となる' do
        book_feeling.book_id = nil
        expect(book_feeling.valid?).to eq(false)
      end
    end

    context 'feeling_idがない場合' do
      it '無効となる' do
        book_feeling.feeling_id = nil
        expect(book_feeling.valid?).to eq(false)
      end
    end

    context '本を削除した場合' do
      it '削除される' do
        book_feeling.save
        expect(BookFeeling.count).to eq(1)
        book_feeling.book.destroy
        expect(BookFeeling.count).to eq(0)
      end
    end

    context 'どんな時にを削除した場合' do
      it '削除される' do
        book_feeling.save
        expect(BookFeeling.count).to eq(1)
        book_feeling.book.destroy
        expect(BookFeeling.count).to eq(0)
      end
    end

  end
end
