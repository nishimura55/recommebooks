

def log_in_as(user)
    visit login_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
end

def log_out
    visit root_path
    find(".dropdown-toggle").click
    click_on 'ログアウト'
end
