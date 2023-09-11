.PHONY: container cnrotary dercu dercd dersu \
 migrateup migratedown psql

# make container in order of list on first line
container: cnrotary dercu
	echo "make container completed"

# create Container running postgres alpine database
# name = cnrotary 
# local files rotary/pg-docker
# local port 5434
cnrotary:
	docker run --name cnrotary -p 5434:5432 \
	-e POSTGRES_PASSWORD=pw \
	-v $(PWD)/pg-docker:/var/lib/postgresql/data \
	-d postgres:15.3-alpine3.18
# if POSTGRES_USER=root not specified, defaults to user postgres
# can set POSTGRES_DB=<name> otherwise is same as POSTGRES_USER
# POSTGRES_PASSWORD (not required for localhost) re POSTGRES_USER (superuser)
# PGPASSWORD is used by psql at runtime

# create User
# name umds (to identify from any other use of mds)
# allocated all roles including SUPERUSER
# PASSWORD pwms
dercu:
	docker exec -tiu postgres cnrotary psql \
	-c "CREATE USER umds SUPERUSER CREATEDB CREATEROLE PASSWORD 'pwms';"
# not used ALTER USER - see https://www.postgresql.org/docs/current/sql-alteruser.htm

# create DataBase
# name dbrotary
dercd:
	docker exec -tiu postgres cnrotary psql \
	-c "CREATE DATABASE dbrotary;"




# set user as umds
dersum:
	docker exec -tiu postgres cnrotary psql -c "SET ROLE umds;"

# set user as postgres
dersup:
	docker exec -tiu umds cnrotary psql -c "SET ROLE postgres;"

# select current user
derscu:
	docker exec -tiu postgres cnrotary psql -c "SELECT current_user, session_user;"

# docker exec rotary psql
derp:
	docker exec -tiu postgres cnrotary psql
# User = umds
# DB mame = dbrotary
# Password = pw


DB_URL=postgresql://umds:pwms@localhost:5434/dbrotary?sslmode=disable

migrateup:
	migrate -path db/migration -database "$(DB_URL)" -verbose up

migratedown:
	migrate -path db/migration -database "$(DB_URL)" -verbose down

psql:
	docker exec -it cnrotary psql -U umds dbrotary
#            container^         user^     ^database name if set
# root=# select now();
# root=# \q (quit)	

sh:
	docker exec -it cnrotary /bin/sh
# bash is sh, but with more features and better syntax. Bash is “Bourne Again SHell”
bash:
	docker exec -it cnrotary /bin/bash
#            container^
# /# exit
# /# ls 		list
# /# ls -a		list all
# /# ls -l		list as list
# /# ls -al		list all as list

sqlc:
	sqlc generate

test:
	go test -v -cover -short ./...



















# PROBABLY NOT USED BELOW?
# docker run rotary
drr:
	docker run --name cntr -p 5435:5432 \
	-e POSTGRES_PASSWORD=pw \
	-d postgres:latest


# docker exec rotary shell
ders:
	docker exec -tiu postgres cntr /bin/sh

# docker exec rotary bash
derb:
	docker exec -tiu postgres cntr /bin/bash

# docker exec rotary create data base
dercdb:
	docker exec -tiu postgres cntr createdb --username=mds --owner=mds

derpumr:
	docker exec -it cntr psql -U michael rcotdata
#            container^         user^     ^database name if set
# root=# select now();
# root=# \q (quit)	
	

drb:
	docker run --name beaver -p 5439:5432 -e POSTGRES_PASSWORD=pw -d postgres:latest
eb:
	docker exec -tiu postgres beaver psql
sb:
	docker stop beaver
rb:
	docker rm beaver
ab:
	docker start beaver

psqlddb:
	docker exec -it rcotdb psql -U michael -d rcotdata -c "DROP DATABASE rcotdata WITH (FORCE);"

psqle:
	docker exec -it rcotdb psql -U michael -d rcotdata -c "echo Helloa;"


createdb:
	docker exec -it rcotdb createdb --username=michael --owner=michael

cdb:
	docker exec -it rcotdb createdb --username=fred --owner=fred

ddb:
	docker exec -it rcotdb -U michael dropdb rcotdata

dropdb:
	docker exec -it rcotdb dropdb rcotdata


psqlde:
	docker exec -it rcotdb psql -U michael -d rcotdata -c "echo Helloa;"




new_migration:
	migrate create -ext sql -dir db/migration -seq $(name)
# make new_migration name=whatever



hello:
	@echo "Hello to *"$(who)

.PHONY: rotarypgdb bash createdb dropdb hello eb rb sb drr der