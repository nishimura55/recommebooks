require 'rails_helper'

RSpec.describe 'フォローについてのリクエストテスト', type: :request do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    describe 'フォロー' do
        context 'ログインしていないとき' do
            it 'フォローできずログイン画面になる' do        
                expect do
                  post user_relationships_path(user), params: { relationship: { followed_id: other_user.id } }
                end.to change(user.following, :count).by(0)
                expect(response.status).to eq 302
                expect(response).to redirect_to login_path
            end
        end

        context 'ログインしているとき' do
            it 'フォローできる' do 
                log_in_by_post_request_as(user)
                expect do
                  post user_relationships_path(user), params: { relationship: { followed_id: other_user.id } }
                end.to change(user.following, :count).by(1)
            end

            it 'Ajaxでフォローできる' do 
                log_in_by_post_request_as(user)
                expect do
                  post user_relationships_path(user), params: { relationship: { followed_id: other_user.id } }, xhr: true
                end.to change(user.following, :count).by(1)
            end
        end
    end

    describe 'フォロー解除' do
        before do
            log_in_by_post_request_as(user)
            post user_relationships_path(user), params: { relationship: { followed_id: other_user.id } }
        end
        
        context 'ログインしていないとき' do
            it 'フォロー解除できずログイン画面になる' do 
                log_out_by_delete_request
                relationship = user.active_relationships.find_by(followed_id: other_user.id)
                expect do
                  delete user_relationship_path(user, relationship)
                end.to change(user.following, :count).by(0)
                expect(response.status).to eq 302
                expect(response).to redirect_to login_path
            end
        end

        context 'ログインしているとき' do
            it 'フォロー解除できる' do 
                relationship = user.active_relationships.find_by(followed_id: other_user.id)
                expect do
                  delete user_relationship_path(user, relationship)
                end.to change(user.following, :count).by(-1)
            end

            it 'Ajaxでフォロー解除できる' do 
                relationship = user.active_relationships.find_by(followed_id: other_user.id)
                expect do
                  delete user_relationship_path(user, relationship), xhr: true
                end.to change(user.following, :count).by(-1)
            end
        end
    end
end