DC=docker-compose
DC_EXEC=$(DC) exec
FRONTEND=$(DC_EXEC) sudoku
NPM=$(FRONTEND) npm run

start:
	$(DC) up -d

stop:
	$(DC) stop

ssh:
	$(FRONTEND) sh

install:
	$(FRONTEND) npm install

dev:
	$(NPM) serve
