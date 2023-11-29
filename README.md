# 概要
railsでリファクタリングした自作アプリです  
ローカルでの使用を想定しています

# 必要環境
* git  
* docker  
* docker-Compose  
が使えればOK

# アプリ環境
* ruby 3.2.2  
* rails 7.1.1  
* MYSQL 8.0  

# 使い方

1. ソースコードをDLします  
`git clone https://github.com/pm306/ac-by-rails.git`
2. ルートディレクトリに移動します  
`cd ac-by-rails`
4. コンテナをビルドします  
`docker-compose build`
6. コンテナを立ち上げます  
`docker-compose up -d`
8. `docker-compose run web rails db:migrate`
9. `docker-compose run web rails db:seed`
10. `docker-compose run web rails dartsass:build`
11. `http://localhost:3000`にアクセスします

# データを初期化したくなったら
`docker-compose run web rails db:reset` で初期化できます

# コンテナを停止させる
`docker-compose down -v`
