require 'rails_helper'

RSpec.describe 'レコメンド作成のリクエストテスト', type: :request do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:book) { create(:book) }

    context 'ユーザーがログインしていないとき' do
        it '302レスポンスが返されログイン画面に移行する' do
            post recommends_path, params: { recommend: { recommender_id: user.id,
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
        context 'パラメータが有効のとき' do
            it 'レコメンドできる' do
                log_in_by_post_request_as(user)
                expect do
                  post recommends_path, params: { recommend: { recommender_id: user.id,
                                                               recommended_id: other_user.id,
                                                               book_id: book.id,
                                                               body: "おすすめです！"
                                                              }       
                                                 }                    
                end.to change(user.recommending, :count).by(1)
            end
        end

        context 'パラメータが無効のとき' do
            it 'レコメンドできない' do
                log_in_by_post_request_as(user)
                expect do
                    post recommends_path, params: { recommend: { recommender_id: nil,
                                                                 recommended_id: other_user.id,
                                                                 book_id: book.id,
                                                                 body: "おすすめです！"
                                                                }       
                                                   }
                    expect(response.status).to eq 200
                end.to change(user.recommending, :count).by(0)
                expect(response).to render_template('recommends/new')
            end
        end
        
    end


end