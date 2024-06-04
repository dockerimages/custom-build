#!/bin/bash
source /root/.bashrc

# Set color
# YELLOW='\033[1;33m'
# GREEN='\033[0;32m'
# NC='\033[0m' # No Color

# TODO: BUILD_COMMAND? NODE_CMD="npx -p node@${version} -p npm@$NPM_VERSION -p yarn@version"

# Install Ruby if RUBY_VERSION is specified
# if [ "$RUBY_VERSION" ]; then
#   current_version=$(ruby -v | cut -d " " -f 2)
  
#   echo "Ruby version $RUBY_VERSION is different from the default Ruby version. Installing Ruby version $RUBY_VERSION..."
#   rbenv install "$RUBY_VERSION" && rbenv global "$RUBY_VERSION"
# fi

# # Install Python if PYTHON_VERSION is specified
# if [ "$PYTHON_VERSION" ]; then
#   echo "Python installation logic goes here for version $PYTHON_VERSION"
# fi

# # Install Go if GO_VERSION is specified
# if [ "$GO_VERSION" ]; then
#   eval "$(gimme "$GO_VERSION")"
#   echo "Go installation logic goes here for version $GO_VERSION"
# fi

# # Handle NPM_TOKEN
# if [ "$NPM_TOKEN" ]; then
#   echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" > ~/.npmrc
# fi

# # Handle YARN_NPM_AUTH_TOKEN
# if [ -n "$YARN_NPM_AUTH_TOKEN" ]; then
#   echo "//registry.yarnpkg.com/:_authToken=$YARN_NPM_AUTH_TOKEN" > ~/.yarnrc
# fi

# # run build script:
# cd /app
# ls -al
# if [ "$USE_YARN" = "true" ]; then
#   echo $YARN_FLAGS
#   if [ -n "$YARN_FLAGS" ]; then
#     echo -e "${GREEN} Using yarn install with flags from environment: ${YARN_FLAGS} ${NC}"
#     echo "$YARN_FLAGS yarn install && $BUILD_COMMAND"
#     export $YARN_FLAGS yarn install && $BUILD_COMMAND
#   else
#     echo -e "${GREEN} Using yarn install without flags ${NC}"
#     yarn install
#   fi
# else
#   if [ -n "$NPM_FLAGS" ]; then
#     echo -e "${GREEN} Using npm install with flags: ${NPM_FLAGS} ${NC}"
#     export $NPM_FLAGS npm install && $BUILD_COMMAND
#   else
#     echo -e "${GREEN} Using npm install without flags ${NC}"
#     npm install
#   fi
# fi
node /entrypoint.js "$@"
# exec "$@"
