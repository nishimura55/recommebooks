require 'rails_helper'

RSpec.describe 'ジャンルモデルのテスト', type: :model do
  let(:genre) { create(:genre) }

  describe 'バリデーションのテスト' do

    context '全てのカラムが正しい場合' do
      it '有効となる' do
        expect(genre).to be_valid
      end
    end

    context 'nameがない場合' do
      it '無効となる' do
        genre.name = nil
        expect(genre.valid?).to eq(false)
      end
    end
    
  end
  
end

