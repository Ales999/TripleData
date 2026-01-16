docker buildx build . -t tabix-dev:v22.05.17
echo Start Image:
echo docker run -d --restart=always --name tabix_for_clickhouse-dev -p 80:80 tabix-dev:v22.05.17
