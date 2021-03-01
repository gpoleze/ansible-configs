docker run -it -d           \
  --name hello-world-1      \
  --restart unless-stopped  \
  -p 127.0.0.11:8080:80     \
  gpoleze/tutum-hello-world

docker run -it -d           \
  --name hello-world-2      \
  --restart unless-stopped  \
  -p 127.0.0.12:8080:80     \
  gpoleze/tutum-hello-world

docker run -d                         \
  --name ha                           \
  --network host                      \
  -v "$(pwd):/usr/local/etc/haproxy/" \
  haproxy:2.3 