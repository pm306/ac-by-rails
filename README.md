# 概要
railsでリファクタリングした自作アプリです  
ローカルでの使用を想定しています

# 必要環境
* git  
* docker  
* docker-compose

# アプリケーション環境
* ruby 3.2.2  
* rails 7.1.1  
* MYSQL 8.0  

# 使い方

1. アプリをダウンロードします  
`git clone https://github.com/pm306/ac-by-rails.git`
2. ルートディレクトリに移動します  
`cd ac-by-rails`
3. コンテナをビルドします  
`docker-compose build`  
面倒な人は`make all`で3~7を一気に進められます（バグ発生中）
4. コンテナを立ち上げます  
`docker-compose up -d`
5. DBをマイグレーションします  
`docker-compose run --rm web rails db:migrate`
7. 初期データを生成します。テストユーザーの各データや選択ロジックが生成されます。
`docker-compose run --rm web rails db:seed`
8. sassをプリコンパイルします  
`docker-compose run --rm web rails dartsass:build`
9. `http://localhost:3000`にアクセスします

# データを初期化したくなったら
`docker-compose run --rm web rails db:reset`

# コンテナを停止させる
`docker-compose down -v`か`make down`
