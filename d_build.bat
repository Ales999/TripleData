docker buildx build . -t tabix:v22.05.17
docker run -d --restart=always --name tabix_for_clickhouse-22.05.17 -p 80:80 tabix:v22.05.17
