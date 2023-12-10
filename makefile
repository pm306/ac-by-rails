# Makefile

build:
	docker-compose build
up:
	docker-compose up -d

setup-db:
	docker-compose run --rm web rails db:migrate
	docker-compose run --rm web rails db:seed

# Dart Sassのビルド
build-sass:
	docker-compose run --rm web rails dartsass:build

# コンテナ立ち上げ～Sassのビルドまでを一度に実行
all: up setup-db build-sass

# DBの初期化
reset:
	docker-compose run --rm web rails db:reset

# コンテナの停止
down: 
	docker-compose down -v
