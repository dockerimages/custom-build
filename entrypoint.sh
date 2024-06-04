#!/bin/bash
# [[ -s "$GVM_ROOT/scripts/gvm" ]] && source "$GVM_ROOT/scripts/gvm"
curl -sSL https://raw.githubusercontent.com/voidint/g/master/install.sh | bash
# echo "unalias g" >> ~/.bashrc # Optional. If other programs (such as `git`) have used `g` as an alias.
mkdir /root/.g/go
source "$HOME/.g/env"
# Set color
# YELLOW='\033[1;33m'
# GREEN='\033[0;32m'
# NC='\033[0m' # No Color

# # TODO: BUILD_COMMAND? NODE_CMD="npx -p node@${version} -p npm@$NPM_VERSION -p yarn@version"

# # Set up NVM if NODE_VERSION is specified
# if [ "$NODE_VERSION" ]; then
#   current_version=$(node -v)
#   desired_version="v$NODE_VERSION"

#   if [ "$current_version" = "$desired_version" ]; then
#     echo "node version is already $desired_version. No need to update."
#   else
#     echo "Found Node version which is different from the default node version. Installing NPM version $NODE_VERSION..."
#     export NVM_DIR="$HOME/.nvm"
#     [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
#     nvm install "$NODE_VERSION"
#   fi
# fi

# # Install npm if NPM_VERSION is specified
# if [ "$NPM_VERSION" ]; then
#   current_version=$(npm -v)
#   desired_version="$NPM_VERSION"
#   if [ "$current_version" = "$desired_version" ]; then
#     echo "npm version is already $desired_version. No need to update."
#   else
#     echo "Found NPM version which is different from the default NPM version. Installing NPM version $NPM_VERSION..."
#     npm install -g npm@$NPM_VERSION
#   fi
# fi

# # Install Yarn if YARN_VERSION is specified
# if [ "$YARN_VERSION" ]; then
#   current_version=$(yarn -v)
#   desired_version="$YARN_VERSION"
#   if [ "$current_version" = "$desired_version" ]; then
#     echo "yarn version is already $desired_version. No need to update."
#   else
#     echo "Found YARN version which is different from the default YARN version. Installing YARN version $YARN_VERSION ..."
#     npm install -g yarn@$YARN_VERSION
#   fi
# fi

# # Set NODE_ENV if not specified
# if [ "$NODE_ENV" ]; then
#   current_value=$(echo "NODE_ENV")
#   if [ "$current_value" = "development" ]; then
#     echo "NODE_ENV is already set to 'production'."
#   else
#     echo "NODE_ENV is not set to 'production'. Setting NODE_ENV to $NODE_ENV..."
#     export NODE_ENV=$NODE_ENV
# fi

# # Install Ruby if RUBY_VERSION is specified
# if [ "$RUBY_VERSION" ]; then
#   current_version=$(ruby -v | cut -d " " -f 2)
  
#   echo "Ruby version $RUBY_VERSION is different from the default Ruby version. Installing Ruby version $RUBY_VERSION..."
#   rbenv install "$RUBY_VERSION" && rbenv global "$RUBY_VERSION"
# fi

# # Install PHP if PHP_VERSION is specified
# if [ "$PHP_VERSION" ]; then
#   echo "PHP installation logic goes here for version $PHP_VERSION"
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
