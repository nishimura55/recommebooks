require 'rails_helper'

RSpec.describe 'タイトルモデルのテスト', type: :model do
  let(:title) { create(:title) }

  describe 'バリデーションのテスト' do
    context '全てのカラムが正しい場合' do
      it '有効となる' do
        expect(title).to be_valid
      end
    end
  end
end
