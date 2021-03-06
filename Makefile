all: build run

clean:
	@R --slave -e "unlink(dir('app/data/users', '^user.*', full.names=TRUE), recursive=TRUE, force=TRUE)"

test:
	R --slave -e "shiny::runApp('app', port=5922, launch.browser=TRUE)"

build:
	docker build -t mapotron .

run:
	docker run -d -v /data:/host/data -p 80:80 --name mapotron mapotron

log:
	docker exec mapotron cat /var/log/shiny-server/shiny-server.log

.PHONY: build all test log
