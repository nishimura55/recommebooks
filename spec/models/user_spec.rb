require 'rails_helper'

RSpec.describe 'ユーザーモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  
  describe 'ユーザー登録のバリデーションのテスト' do
    
    context '全てのカラムが正しい場合' do
      it '正常に登録できる' do
        expect(user).to be_valid
      end
    end

    context '名前がない場合' do
      it '登録ができない' do
        user.name = nil
        expect(user.valid?).to eq(false)
        expect(user.errors[:name]).to include("を入力してください")
      end
    end

    context '名前が45文字を超えた場合' do
      it '登録ができない' do
        user.name = "a" * 46
        expect(user.valid?).to eq(false)
        expect(user.errors[:name]).to include("は45文字以内で入力してください")
      end
    end

    context 'メールアドレスがない場合' do
      it '登録ができない' do
        user.email = nil
        expect(user.valid?).to eq(false)
        expect(user.errors[:email]).to include("を入力してください")
      end
    end

    context 'メールアドレスが255文字を超えた場合' do
      it '登録ができない' do
        user.email = "#{"a" * 256}@example.com"
        expect(user.valid?).to eq(false)
        expect(user.errors[:email]).to include("は255文字以内で入力してください")
      end
    end

    context 'メールアドレスのフォーマットが有効でない場合' do
      it '登録ができない' do
        user.email = "testexample.com"
        expect(user.valid?).to eq(false)
        expect(user.errors[:email]).to include("は不正な値です")
      end
    end

    context 'メールアドレスが一意でない場合' do
      it '登録ができない' do
        user.save
        other_user.email = user.email
        expect(other_user.valid?).to eq(false)
        expect(other_user.errors[:email]).to include("はすでに存在します")
      end
    end

    context 'パスワードがない場合' do
      it '登録ができない' do
        user.password = nil
        expect(user.valid?).to eq(false)
        expect(user.errors[:password]).to include("を入力してください")
      end
    end

    context 'パスワードが6文字より少ない場合' do
      it '登録ができない' do
        user.password = "a" * 5
        expect(user.valid?).to eq(false)
        expect(user.errors[:password]).to include("は6文字以上で入力してください")
      end
    end

    context 'パスワードとパスワード確認が一致しない場合' do
      it '登録ができない' do
        user.password_confirmation = "invalid_password"
        expect(user.valid?).to eq(false)
        expect(user.errors.full_messages.to_s).to include("が一致しません")
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

  describe '認証機能のテスト' do

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
