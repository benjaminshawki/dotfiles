FROM mysql
ENV MYSQL_DATABASE=demo-joel
ENV MYSQL_USER=joel
ENV MYSQL_PASSWORD=db-docker
ENV MYSQL_ROOT_PASSWORD=my-secret

ADD init-db.sql /docker-entrypoint-initdb.d/
