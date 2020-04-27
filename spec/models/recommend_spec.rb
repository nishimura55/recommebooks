require 'rails_helper'

RSpec.describe 'レコメンドのテスト', type: :model do
  let(:recommend) { create(:recommend) }
  let(:other_recommend) { create(:recommend) }

  describe 'バリデーションのテスト' do
    context 'バリデーションを通過した場合' do
      it '有効となる' do
        expect(recommend).to be_valid
      end
    end

    context 'recommender_idがない場合' do
      it '無効となる' do
        recommend.recommender_id = nil
        expect(recommend.valid?).to eq(false)
      end
    end
  
    context 'recommended_idがない場合' do
      it '無効となる' do
        recommend.recommended_id = nil
        expect(recommend.valid?).to eq(false)
      end
    end
  
    context 'book_idがない場合' do
      it '無効となる' do
        recommend.book_id = nil
        expect(recommend.valid?).to eq(false)
      end
    end
  
    context 'レコメンドしたユーザーが削除された場合' do
      it '無効となる' do
        recommend.save
        expect(Recommend.count).to eq(1)
        recommend.recommender.destroy
        expect(Recommend.count).to eq(0)
      end
    end
  
    context 'レコメンドされたユーザーが削除された場合' do
      it '無効となる' do
        recommend.save
        expect(Recommend.count).to eq(1)
        recommend.recommended.destroy
        expect(Recommend.count).to eq(0)
      end
    end
  
    context 'レコメンドした本が削除された場合' do
      it '無効となる' do
        recommend.save
        expect(Recommend.count).to eq(1)
        recommend.book.destroy
        expect(Recommend.count).to eq(0)
      end
    end
  
    context 'recommender_idとrecommended_idとbook_idの組み合わせが同じレコメンドがある場合' do
      it '無効となる' do
        recommend.save
        other_recommend.recommender_id = recommend.recommender_id
        other_recommend.recommended_id = recommend.recommended_id
        other_recommend.book_id = recommend.book_id
        expect(other_recommend.valid?).to eq(false)
      end
    end
  end
end
