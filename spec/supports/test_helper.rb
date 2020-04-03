

def log_in_as(user)
    visit login_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
end

def log_in_by_post_request_as(user)
    post login_path, params: { session: { email: user.email, password: user.password } }
end

def log_out_by_delete_request
    delete logout_path
end

def log_out
    visit root_path
    find(".dropdown-toggle").click
    click_on 'ログアウト'
end
