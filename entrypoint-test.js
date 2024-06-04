// Read all the ENV NAME=VAL stuff from the Dockerfile
const dockerEnv = fs.readFileSync('./Dockerfile','utf8').split("\n").filter(
    line=>line.trim().startsWith("ENV")
).map(
    l => l.trim().slice(4).split("=").join(" ").split(" ").join(": ")
)
require('./entrypoint.js');

/*
docker run  -v "$ROOT_PATH/:/app"  \
-e "BUILD_COMMAND=yarn build" \
-e "USE_YARN=true" 
\-e "PHP_VERSION=8" \
-e "YARN_FLAGS=NODE_OPTIONS=--openssl-legacy-provider" -e "NODE_ENV=production" custom-image:latest 


docker run --rm -e PHP_VERSION=5.6 -e NODE_VERSION=20 localhost/b:latest php --version
returns 5.6

docker run --rm -e PHP_VERSION=5.6 -e NODE_VERSION=20 localhost/b:latest
runs build cmd with correct node version



*/