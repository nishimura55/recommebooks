require 'rails_helper'

RSpec.describe 'ユーザー作成ページのリクエストテスト', type: :request do
    it 'ユーザー作成ページが返される' do
        get new_user_path
        expect(response.status).to eq 200
        expect(response).to render_template('users/new')
    end

end