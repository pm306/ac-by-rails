# 概要
railsでリファクタリングした自作アプリです

# 環境
Docker
Docker-Compose
が使えればOK

# 使い方

1. `git clone https://github.com/pm306/ac-by-rails.git`
2. `path/to/ac-by-rails`
4. `docker-compose build`
6. `docker-compose up -d`
7. `docker-compose run web rails db:migrate`
8. `docker-compose run web rails db:seed`
9. `docker-compose run web rails dartsass:build`

# データを初期化したくなったら
`docker-compose run web rails db:reset` で初期化できます
