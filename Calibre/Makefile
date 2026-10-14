
build:
	docker build -t calibre-dev .

clean:
	docker container rm calibre
	docker image rm calibre-dev

run:
	docker run --name calibre -it calibre-dev
