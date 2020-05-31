# RecommeBooks (レコメブックス)
<img width="818" alt="main-logo" src="https://user-images.githubusercontent.com/61367038/82335118-d9648d80-9a23-11ea-968a-8f495f7a7b3c.png">

## 1. サービス概要
レコメブックスはユーザー同士で本をレコメンドしあうSNSサービスです。  
本をレコメンドした相手から本の評価をもらうことができ、  
評価が「面白かった！」であった場合はレコメンドしたユーザーと本にポイントがたまります。

## 2. URL
https ~  
複数のテストユーザーからテストログインが可能です。レコメンド機能の確認にお使いください。

## 3. 技術スタック
### 言語・フレームワーク
- Ruby 2.7.0  
- Ruby on Rails 6.0.2
### 開発環境
- Docker  
- MySQL
### テスト環境
- RSpec (modelspec・requestspec・systemspec) 合計207examples  
- CircleCI (自動ビルド・自動テスト)
### 本番環境
- AWS (EC2・RDS・S3・ACM・Route53)  
- Unicorn (アプリケーションサーバー)  
- Nginx (Webサーバー)

## 4. インフラ構成図
![Untitled Diagram](https://user-images.githubusercontent.com/61367038/83350090-8e783d80-a374-11ea-8e33-1450a5daac2f.png)

## 5. テーブル設計図
<img width="909" alt="recommebooks" src="https://user-images.githubusercontent.com/61367038/82334587-2431d580-9a23-11ea-9c91-6d67d579a821.png">

## 6. 機能一覧
- ユーザー登録機能
- ログイン・ログアウト機能
- 管理ユーザー機能
- ユーザー画像アップロード機能 (CarrierWave・RMagick)
- フォロー機能 (Ajax)
- タイムライン機能
- 本投稿機能 (楽天API)
- レビュー機能
- お気に入り機能 (Ajax)
- 著者一覧機能
- 他ユーザーへの本のレコメンド機能
- レコメンド評価に応じたポイント機能
- ポイントに応じたユーザーの称号機能
- ランキング表示機能
- 通知機能
- 検索機能 (ransack)
- タグ機能
- ページネーション機能 (will_paginate)
- パンくずリスト機能 (gretel)

## 7. その他ポイント
- レスポンシブ対応 (Bootstrap) ※今後実装予定
- SSL証明書取得 (ACM)
- 独自ドメイン使用 (Route53)
- Githubを活用した開発 (pullrequests・issues)

## 8. 環境構築
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
