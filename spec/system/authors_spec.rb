require 'rails_helper'

RSpec.describe '著者のシステムテスト', type: :system do
    let(:user) { create(:user) }
    let(:author) { create(:author) }

    describe '著者一覧ページのテスト' do

        before do
            create_list(:author, 31)
            visit authors_path
        end

        it '著者一覧ページが表示される' do
            expect(page).to have_title '著者一覧 | Recommebooks'
            expect(page).to have_selector '.pagination'
            Author.paginate(page: 1).each do |author|
                expect(page).to have_link author.name, href: author_path(author)
            end
        end

    end
end