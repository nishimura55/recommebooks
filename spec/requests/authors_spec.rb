require 'rails_helper'

RSpec.describe '著者についてのリクエストテスト', type: :request do
    let(:user) { create(:user) }
    let!(:author) { create(:author) }

    describe '著者一覧ページ' do

        context 'ユーザーがログインしていないとき' do
            it '著者一覧ページが返される' do
                get authors_path
                expect(response.status).to eq 200
                expect(response).to render_template('authors/index')
            end
        end
    
        context 'ユーザーがログインしているとき' do
            it '著者一覧ページが返される' do
                log_in_by_post_request_as(user)
                get authors_path
                expect(response.status).to eq 200
                expect(response).to render_template('authors/index')
            end
        end

    end

    describe '著者詳細ページ' do

        context 'ユーザーがログインしていないとき' do
            it '著者一覧ページが返される' do
                get author_path(author)
                expect(response.status).to eq 200
                expect(response).to render_template('authors/show')
            end
        end
    
        context 'ユーザーがログインしているとき' do
            it '著者一覧ページが返される' do
                log_in_by_post_request_as(user)
                get author_path(author)
                expect(response.status).to eq 200
                expect(response).to render_template('authors/show')
            end
        end

    end


end