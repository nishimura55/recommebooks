require 'rails_helper'

RSpec.describe '著者モデルのテスト', type: :model do
  let(:author) { create(:author) }
  let(:book) { create(:book) }

  describe '著者のバリデーションのテスト' do

    context '全てのカラムが正しい場合' do
      it '有効となる' do
        expect(author).to be_valid
      end
    end

    context 'nameがない場合' do
      it '無効となる' do
        author.name = nil
        expect(author.valid?).to eq(false)
      end
    end
    
  end
end
