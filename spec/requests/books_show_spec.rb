require 'rails_helper'

RSpec.describe '本投稿ページのリクエストテスト', type: :request do
    let(:book) { create(:book) }

    context '本が存在するとき' do
        it '本詳細ページが返される' do
            get book_path(book)
            expect(response.status).to eq 200
            expect(response).to render_template('books/show')
            expect(response.body).to include 'テスト本'
        end
    end

    context '本が存在しない場合' do
        subject { -> { get book_path(1) } }
        it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
end