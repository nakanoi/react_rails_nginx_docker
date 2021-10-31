chmod 775 ./api/server/run.sh
chmod 775 ./api/server/entrypoint.sh
chmod 775 ./frontend/front/run.sh
docker-compose  build
echo "
default: &default
  adapter: mysql2
  encoding: utf8mb4
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: docker
  password: DockerMysql1.0!
  host: db

development:
  <<: *default
  database: server_dev
test:
  <<: *default
  database: server_test

production:
  <<: *default
  database: server_production
  username: server
  password: <%= ENV['SERVER_DATABASE_PASSWORD'] %>
" >> ./api/server/config/database.yml
docker-compose run qiita-rails rails new . --api -d mysql --force
docker-compose run qiita-react npx create-react-app .
sudo chmod -R a=rx,u+wx .
docker-compose up --build
