require 'rails_helper'

RSpec.describe 'どんな時にモデルのテスト', type: :model do
  let(:feeling) { create(:feeling) }

  describe 'バリデーションのテスト' do

    context '全てのカラムが正しい場合' do
      it '有効となる' do
        expect(feeling).to be_valid
      end
    end

    context 'situationがない場合' do
      it '無効となる' do
        feeling.situation = nil
        expect(feeling.valid?).to eq(false)
      end
    end
    
  end
  
end
