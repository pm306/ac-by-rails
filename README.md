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
`make build`  
4. コンテナを立ち上げます
`make up`
5. DBをマイグレーションし、初期データを作成します  
`make setup-db:`
6. sassをプリコンパイルします   
`make build-sass`
7.次のページにアクセスします
 `http://localhost:3000`

# データを初期化したくなったら
`make reset`

# コンテナを停止させる
`make down`
