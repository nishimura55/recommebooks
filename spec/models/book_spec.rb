require 'rails_helper'

RSpec.describe 'ブックモデルのテスト', type: :model do
  let(:book) { create(:book) }
  let(:other_book) { create(:book) }

  describe '本投稿のバリデーションのテスト' do

    context '全てのカラムが正しい場合' do
      it '正常の投稿できる' do
        expect(book).to be_valid
      end
    end

    context 'user_idがない場合' do
      it '投稿ができない' do
        book.user_id = nil
        expect(book.valid?).to eq(false)
      end
    end

    context '題名がない場合' do
      it '投稿ができない' do
        book.title = nil
        expect(book.valid?).to eq(false)
      end
    end

    context '投稿者の感想がない場合' do
      it '投稿ができない' do
        book.contributor_review = nil
        expect(book.valid?).to eq(false)
      end
    end

    context '投稿者の感想が256文字以上の場合' do
      it '投稿ができない' do
        book.contributor_review = "a" * 256
        expect(book.valid?).to eq(false)
      end
    end

    context '楽天URLがない場合' do
      it '投稿ができない' do
        book.rakuten_url = nil
        expect(book.valid?).to eq(false)
      end
    end

    context 'すでに投稿されている本の場合' do
      it '投稿できない' do
        book.save
        other_book.rakuten_url = book.rakuten_url
        expect(other_book.valid?).to eq(false)
      end
    end



  end
  
end
