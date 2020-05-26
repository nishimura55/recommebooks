crumb :root do
  link "トップページ", root_path
end

crumb :user_new do
  link "新規登録", new_user_path
  parent :root
end

crumb :user_login do
  link "ログイン", login_path
  parent :root
end

crumb :book_search do
  link "本を検索", search_books_path
  parent :root
end

crumb :book_new do
  link "本を投稿", new_book_path
  parent :book_search
end

crumb :recommend do
  link "レコメンド", new_recommend_path
  parent :root
end

crumb :recommend_book do
  link "レコメンドする本を選ぶ", recommends_books_path
  parent :recommend
end

crumb :recommend_user do
  link "レコメンドするユーザーを選ぶ", recommends_users_path
  parent :recommend
end

crumb :books do
  link "本一覧", books_path
  parent :root
end

crumb :book do |book|
  link "#{book.title}", book_path(book)
  parent :books
end

crumb :authors do
  link "著者一覧", authors_path
  parent :root
end

crumb :author do |author|
  link "#{author.name}", author_path(author)
  parent :authors
end

crumb :users do
  link "ユーザー一覧", users_path
  parent :root
end

crumb :user do |user|
  link "#{user.name}", user_path(user)
  parent :users
end

crumb :my_page do
  link "マイページ", user_path(current_user)
  parent :root
end

crumb :user_edit do |user|
  link "プロフィール編集", edit_user_path(user)
  parent :my_page
end

crumb :my_recomme_index do |user|
  link "レコメンド状況", user_recommends_path(user)
  parent :my_page
end

crumb :user_recomme_index do |user|
  link "レコメンド状況", user_recommends_path(user)
  parent :user, user
end

crumb :notice_index do
  link "通知一覧", notifications_path
  parent :root
end