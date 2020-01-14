Moby Dock App Upgrade

This app was inspired by Nick Janetakis Course - Docker for DevOps on A Cloud Guru https://acloud.guru/
with modification and upgrade to the python, gunicorn, and redis versions

- Run docker-compose up -d to have the app run in detached mode
- In another tab create the data with: docker exec mobydock_postgres_1 createdb -U postgres mobydock if it already exists you can move on to the next command
- Create a user in postgres docker exec mobydock_postgres _1 psql -U postgres -c "CREATE USER mobydock WITH PASSWORD 'yourpassword'; GRANT ALL PRIVILEGES ON DATABASE mobydock to mobydock;  "
- Seed the database by visiting http://localhost:8000/seed


