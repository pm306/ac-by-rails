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
3. `bundle install` を実行する
3. `rails dartsass:build` を実行する(sassのプリコンパイル)
4. `rails db:create`を実行する
5. `rails db:migrate`を実行する
6. `rails server` を実行する

# データを初期化したくなったら
`rails db:reset` で初期化できます
