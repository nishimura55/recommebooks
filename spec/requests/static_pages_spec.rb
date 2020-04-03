require 'rails_helper'

RSpec.describe 'スタティックページについてのリクエストテスト', type: :request do

    it 'ホーム画面が表示される' do
        get root_path
        expect(response.status).to eq 200
        expect(response).to render_template('static_pages/home')
    end
    
end