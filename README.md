## 1. サービス概要
レコメブックスはユーザー同士で本をレコメンドしあうSNSサービスです。  
本をレコメンドした相手から本の評価をもらうことができ、  
評価が「面白かった！」であった場合はレコメンドしたユーザーと本にポイントがたまります。  
ユーザーをフォローして投稿(本・レビュー)をタイムラインで確認することにより、  
そのユーザーにぴったりの本をレコメンドすることができます。  

## 2. URL
~~https://www.recommebooks.com~~

## 3. 技術スタック
### 言語・フレームワーク
- Ruby 2.7.0  
- Ruby on Rails 6.0.2
### 開発環境
- Docker  
- MySQL
### テスト環境
- RSpec (modelspec・requestspec・systemspec) 
- CircleCI (自動テスト)
### デプロイ
- CircleCI × Capistrano (自動デプロイ)
### 本番環境
- AWS (EC2・RDS・S3・ACM・Route53)  
- Unicorn (アプリケーションサーバー)  
- Nginx (Webサーバー)

## 4. インフラ構成図
![Untitled Diagram](https://user-images.githubusercontent.com/61367038/83350090-8e783d80-a374-11ea-8e33-1450a5daac2f.png)

## 5. テーブル設計図
<img width="909" alt="recommebooks" src="https://user-images.githubusercontent.com/61367038/82334587-2431d580-9a23-11ea-9c91-6d67d579a821.png">

## 6. レコメンド機能仕様
- 他ユーザーへの本のレコメンド
  - 効果的なレコメンドが行われるために下記のレコメンドは禁止
    - そのユーザーがすでにレコメンドされたことのある本のレコメンド
    - そのユーザーがレコメンドしたことのある本のレコメンド
    - そのユーザーが投稿した本のレコメンド
  - レコメンドされたユーザーは通知画面及びレコメンド状況画面においてレコメンドを確認
- レコメンドに対する評価
  - レコメンドされたユーザーが3段階で評価
    - 「面白かった！」
    - 「合わなかったかも」
    - 「読んだことがある」
  - 「面白かった！」評価であった場合、レコメンドしたユーザーと本にポイントが貯まる
  - レコメンドしたユーザーは通知画面及びレコメンド状況画面において評価を確認
- ポイントに応じたユーザーの称号切り替え
  - 3段階あり
    - 「レコメビギナー」(1-4ポイント)
    - 「レコメベテラン」(5-14ポイント)
    - 「レコメマスター」(15-ポイント)

## 7. その他機能一覧
- ユーザー登録機能
- ログイン・ログアウト機能
- 管理ユーザー機能
- ユーザー画像アップロード機能 (CarrierWave・RMagick)
- フォロー機能 (Ajax)
- タイムライン機能
- 本投稿機能 (楽天API)
- レビュー機能
- ネタバレ投稿(ぼかし)機能
- お気に入り機能 (Ajax)
- 著者一覧機能
- ランキング表示機能
- 通知機能
- 検索機能 (ransack)
- タグ機能
- ページネーション機能 (will_paginate)
- パンくずリスト機能 (gretel)
- レスポンシブ対応 (Bootstrap)

## 8. 開発上のポイント
- Githubを活用した開発 (pullrequests・issues)
- コードレビューを実施いただきました(https://github.com/nishimura55/recommebooks/pull/165)

## 9. 環境構築
### ビルド
```
$ docker-compose build
```

### DB設定
```
$ docker-compose run web bundle exec rails db:create
$ docker-compose run web bundle exec rails db:migrate
$ docker-compose run web bundle exec rails db:seed
```

### 起動
```
$ docker-compose up
```

http://localhost:3000 にアクセス
