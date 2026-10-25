
build:
	docker build -t pokeemerald-dev .

clean:
	docker container rm pokeemerald
	docker image rm pokeemerald-dev

run:
	docker run --name pokeemerald -it pokeemerald-dev 
