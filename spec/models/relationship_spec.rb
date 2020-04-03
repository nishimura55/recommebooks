require 'rails_helper'

RSpec.describe 'フォローのテスト', type: :model do
  let(:relationship) { create(:relationship) }

  describe 'バリデーションのテスト' do
    context 'バリデーションを通過した場合' do
      it '有効となる' do
        expect(relationship).to be_valid
      end
    end

    context 'follower_idがない場合' do
      it '無効となる' do
        relationship.follower_id = nil
        expect(relationship.valid?).to eq(false)
      end
    end

    context 'followed_idがない場合' do
      it '無効となる' do
        relationship.followed_id = nil
        expect(relationship.valid?).to eq(false)
      end
    end

    context 'フォローしているユーザーが削除された場合' do
      it '無効となる' do
        relationship.save
        expect(Relationship.count).to eq(1)
        relationship.follower.destroy
        expect(Relationship.count).to eq(0)
      end
    end

    context 'フォローされているユーザーが削除された場合' do
      it '無効となる' do
        relationship.save
        expect(Relationship.count).to eq(1)
        relationship.followed.destroy
        expect(Relationship.count).to eq(0)
      end
    end

  end
  
end
