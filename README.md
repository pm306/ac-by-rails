# 概要
railsでリファクタリングした自作アプリです
最低限の記述しかしていません。後で書きます

# 環境
後でちゃんと書きます
WSL2
Ubuntu22.04
SQLite3
rails

# 使い方

1. `git clone https://github.com/pm306/ac-by-rails.git`を実行する
2. ルートディレクトリに移動する
3. `docker-compose build`を実行する
4. `docker-compose up -d`を実行する
5. `docker-compose run web rails db:migrate`を実行する
6. `docker-compose run web rails db:seed`を実行する

# データを初期化したくなったら
`docker-compose run web rails db:reset` で初期化できます
