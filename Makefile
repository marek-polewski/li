all:  build start

build:
	docker-compose build

start:
	docker-compose up -d --scale web=2

# at least 1 minute after start
check:
	curl  127.0.0.1:8080/featureserver.cgi/postgis/1.atom
