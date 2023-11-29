# Makefile

# コンテナのビルドと起動
up:
	docker-compose build
	docker-compose up -d

# データベースの初期設定
setup-db:
	docker-compose run web rails db:migrate
	docker-compose run web rails db:seed

# Dart Sassのビルド
build-sass:
	docker-compose run web rails dartsass:build

# すべてを一度に実行
all: up setup-db build-sass

# コンテナの停止
down: docker-compose down -v
