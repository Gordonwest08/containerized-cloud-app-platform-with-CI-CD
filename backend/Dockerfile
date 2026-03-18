#1 Official PostgreSQL base image
FROM postgres:16-alpine

#2 Set environment defaults (overridden by ECS/compose)
ENV POSTGRES_DB=appdb
ENV POSTGRES_USER=appuser
ENV POSTGRES_PASSWORD=securepassword


#3 Copy initialization scripts
COPY db-init/init.sql /docker-entrypoint-initdb.d/


#4 Expose postgreSQL port
EXPOSE 5432