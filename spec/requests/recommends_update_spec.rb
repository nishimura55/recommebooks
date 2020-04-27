require 'rails_helper'

RSpec.describe 'レコメンド更新のリクエストテスト', type: :request do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:book) { create(:book) }
    let(:recommend) { create(:recommend) }

    context 'ユーザーがログインしていないとき' do
        it '302レスポンスが返されログイン画面に移行する' do
            put recommend_path(recommend), params: { recommend: { recommender_id: user.id,
                                                                  recommended_id: other_user.id,
                                                                  book_id: book.id,
                                                                  body: "おすすめです！"
                                                                 }       
                                                    } 
            expect(response.status).to eq 302
            expect(response).to redirect_to login_path
        end
    end

    context 'ユーザーがログインしているとき' do
        context 'パラメータが有効な場合' do
            it 'レコメンドの更新ができる' do
                log_in_by_post_request_as(user)
                put recommend_path(recommend), params: { recommend: { recommender_id: user.id,
                                                         recommended_id: other_user.id,
                                                         book_id: book.id,
                                                         body: "おすすめです！",
                                                         status: 2
                                                        }       
                                           } 
                expect(response.status).to eq 302
                expect(response).to redirect_to user_recommends_path(user)
                follow_redirect!
                expect(response).to render_template('recommends/index')
                expect(response.body).to include "面白かった！"
            end
        end

        context 'パラメータが無効な場合' do
            it 'レコメンドの更新ができない' do
                log_in_by_post_request_as(user)
                put recommend_path(recommend), params: { recommend: { recommender_id: user.id,
                                                         recommended_id: other_user.id,
                                                         book_id: book.id,
                                                         body: "おすすめです！",
                                                         status: nil
                                                        }       
                                           } 
                expect(response.status).to eq 302
                expect(response).to redirect_to user_recommends_path(user)
                follow_redirect!
                expect(response).to render_template('recommends/index')
            end
        end
    end
end