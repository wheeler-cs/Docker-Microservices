
build:
	docker build -t calibre-dev .

clean:
	docker container rm calibre
	docker image rm calibre-dev

run:
	docker run -p 127.0.0.1:28080:8080 --name calibre -it calibre-dev 
