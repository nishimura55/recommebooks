require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  
  describe 'ユーザー登録のバリデーションの確認' do
    
    context '全てのカラムが正しい場合' do
      it '正常に登録できる' do
        expect(user).to be_valid
      end
    end

    context '名前がない場合' do
      it '登録ができない' do
        user.name = nil
        expect(user.valid?).to eq(false)
      end
    end

    context '名前が45文字を超えた場合' do
      it '登録ができない' do
        user.name = "a" * 46
        expect(user.valid?).to eq(false)
      end
    end

    context 'メールアドレスがない場合' do
      it '登録ができない' do
        user.email = nil
        expect(user.valid?).to eq(false)
      end
    end

    context 'メールアドレスが255文字を超えた場合' do
      it '登録ができない' do
        user.email = "#{"a" * 256}@example.com"
        expect(user.valid?).to eq(false)
      end
    end

    context 'メールアドレスのフォーマットが有効でない場合' do
      it '登録ができない' do
        user.email = "testexample.com"
        expect(user.valid?).to eq(false)
      end
    end

    context 'メールアドレスが一意でない場合' do
      it '登録ができない' do
        user.save
        other_user.email = user.email
        expect(other_user.valid?).to eq(false)
      end
    end

    context 'パスワードがない場合' do
      it '登録ができない' do
        user.password = nil
        expect(user.valid?).to eq(false)
      end
    end

    context 'パスワード確認がない場合' do
      it '登録ができない' do
        user.password_confirmation = nil
        expect(user.valid?).to eq(false)
      end
    end

    context 'パスワードが6文字より少ない場合' do
      it '登録ができない' do
        user.password = "a" * 5
        expect(user.valid?).to eq(false)
      end
    end

    context 'パスワードとパスワード確認が一致しない場合' do
      it '登録ができない' do
        user.password_confirmation = "invalid_password"
        expect(user.valid?).to eq(false)
      end
    end

    context '好きなジャンルが45文字を超えた場合' do
      it '登録ができない' do
        user.favorite_genre = "a" * 46
        expect(user.valid?).to eq(false)
      end
    end

    context '自己紹介が255文字を超えた場合' do
      it '登録ができない' do
        user.profile = "a" * 256
        expect(user.valid?).to eq(false)
      end
    end

  end

  describe '認証機能の確認' do

    context '正しいパスワードの場合' do
      it '正常に認証される' do
        expect(user.authenticate("password")).to be_truthy
      end
    end

    context '正しくないパスワードの場合' do
      it '認証がされない' do
        expect(user.authenticate("invalid_password")).to eq(false)
      end
    end

  end
  
end
