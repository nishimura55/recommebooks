require 'rails_helper'

RSpec.describe 'ユーザーのジャンルのテスト', type: :model do
  let(:user_genre) { create(:user_genre) }
  let(:user) { create(:user) }
  let(:genre) { create(:genre) }

  describe 'バリデーションのテスト' do
    context 'バリデーションを通過した場合' do
      it '有効となる' do
        expect(user_genre).to be_valid
      end
    end

    context 'user_idがない場合' do
      it '無効となる' do
        user_genre.user_id = nil
        expect(user_genre.valid?).to eq(false)
      end
    end

    context 'genre_idがない場合' do
      it '無効となる' do
        user_genre.genre_id = nil
        expect(user_genre.valid?).to eq(false)
      end
    end

    context 'ユーザーを削除した場合' do
      it '削除される' do
        user_genre.save
        expect(UserGenre.count).to eq(1)
        user_genre.user.destroy
        expect(UserGenre.count).to eq(0)
      end
    end

    context 'ジャンルを削除した場合' do
      it '削除される' do
        user_genre.save
        expect(UserGenre.count).to eq(1)
        user_genre.genre.destroy
        expect(UserGenre.count).to eq(0)
      end
    end

  end
end
