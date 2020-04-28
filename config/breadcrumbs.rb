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

crumb :recomme_index do |user|
  link "レコメンド状況", user_recommends_path(user)
  parent :my_page
end

crumb :notice_index do
  link "通知一覧", notifications_path
  parent :root
end





# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).