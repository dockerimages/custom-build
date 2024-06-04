const { execSync: RUN } = require("node:child_process");
const { log: LOG } = console;

// Setting eventual existing propertys from the environment supplyed via docker
const env = Object.assign({
    // defaults to `node:latest` of the docker image If not provided
    NODE_VERSION: "",
    // defaults to `production` if not specified 
    NODE_ENV: "production",
    // value that sets the npm version. ( defaults to `dockerimage version` if not specified )
    NPM_VERSION: "",
    // value passed as when running npm install. (accept `null` if not specified )
    NPM_FLAGS: "",
    // used for fetching private npm modules. (  accept `null` if not specified )
    NPM_TOKEN: "",
    // yarn version ( (accept `1.22.22` if not specified )
    YARN_VERSION: "",
    // value passed as when running yarn install.  (accept `null` if not specified )
    YARN_FLAGS: "",
    // used for fetching private npm modules with Yarn. (accept `null` if not specified )
    YARN_NPM_AUTH_TOKEN: "",
    // passed as flags on the `pnpm install` command. (accept `null` if not specified )
    PNPM_FLAGS: "",
    // value that sets the Python version.  (accept `3.10` if not specified )
    PYTHON_VERSION: "",
    // passed as flags on the `bun install` command. (accept `null` if not specified )
    BUN_FLAGS: "",
    // used to set the Ruby version. ( default to `latest` ruby version if not specified )
    RUBY_VERSION: "latest",
    // value that sets the PHP version. ( default to `php7` if not specified )
    PHP_VERSION: "7",
    // value that sets the Go version. ( defaults to `go1.19.3` if not specified )
    GO_VERSION: "1.19.3",
    // ENV USE_YARN="false" in dockerfile 
    USE_YARN:"false",
     // used to enable/disable PullRequest pipeline.  ( defaults to `disable` if not specified )
    PANDA_PREVIEW: 'disabled',
    // true/false will enable/disable pipeline trigger. ( defaults to `true` if not specified )
    PANDA_CI: true
},process.env)

const usesYarn = env.USE_YARN || Object.keys(env).filter(key=key.startsWith('YARN')).find(yarnKey=>env[yarnKey]);

// # Set color '\033[1;33m'; === '\x1b[1;33m';
const YELLOW='\x1b[1;33m';
const GREEN='\x1b[0;32m';
const NC='\x1b[0m'; // No Color

const testPathPrefix = __dirname;

const installRubyGlobal = ()=>{
    RUN(`apt-get install rbenv ruby-build`);
    // RUN(`git clone https://github.com/sstephenson/rbenv.git ${testPathPrefix}/usr/local/rbenv`);
    // fs.writeFileSync(`${testPathPrefix}/etc/profile.d/rbenv.sh`,`# rbenv setup
    // export RBENV_ROOT=/usr/local/rbenv
    // export PATH="$RBENV_ROOT/bin:$PATH"
    // ${RUN(`eval "$(${`${testPathPrefix}/etc/profile.d/rbenv.sh`} init -)"`)}`); // Check if rbenv would work some how if we get it executeable
    // fs.chmod(testPathPrefix+"/etc/profile.d/rbenv.sh",'+x')    
    // TODO: check if better RUNSync(`echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh`);
    
    // TODO: This gets set inside the docker image we need to discuess how to handle that
    // ENV RBENV_ROOT=/usr/local/rbenv
    // ENV PATH="$RBENV_ROOT/bin:$RBENV_ROOT/shims:$PATH"

    // # Install ruby-build
    // mkdir /usr/local/rbenv/plugins
    // git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build
    // /usr/local/rbenv/plugins/ruby-build/install.sh
    // rbenv install 2.6.2 && rbenv global 2.6.2
    // gem install bundler -v 2.4.22
};
const installPhpGlobal = ()=>{
    RUN('wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list')
    RUN('apt-get update')
};
const installNodeGlobal = ()=>{};
const installPythonGlobal = ()=>{};
const installGoGlobal = ()=>{};
const useNode = (NODE_VERSION=env[NODE_VERSION]) =>{
    RUN(`npx ${ // Packages
        NODE_VERSION ? `-p node@${NODE_VERSION}` : ""
    } ${
        NPM_VERSION ? `-p npm@${NPM_VERSION}`: ""
    } ${env.YARN_VERSION ? `-p yarn@${YARN_VERSION}` : usesYarn ? "-p yarn" : ""
    } ${ // install cmd TODO: Clear behavior of BUILD_COMMAND=npm install
        env.BUILD_COMMAND || usesYarn ? "yarn" : "npm install"
    }`,{ env });
    // Use NPM SET YARN SET to edit rc files
    // # Handle NPM_TOKEN
    // if [ "$NPM_TOKEN" ]; then
    //   echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" > ~/.npmrc
    // fi
    
    // # Handle YARN_NPM_AUTH_TOKEN
    // if [ -n "$YARN_NPM_AUTH_TOKEN" ]; then
    //   echo "//registry.yarnpkg.com/:_authToken=$YARN_NPM_AUTH_TOKEN" > ~/.yarnrc
    // fi
    
    // # run build script:
    // cd /app
    // ls -al
    // if [ "$USE_YARN" = "true" ]; then
    //   echo $YARN_FLAGS
    //   if [ -n "$YARN_FLAGS" ]; then
    //     echo -e "${GREEN} Using yarn install with flags from environment: ${YARN_FLAGS} ${NC}"
    //     echo "$YARN_FLAGS yarn install && $BUILD_COMMAND"
    //     export $YARN_FLAGS; yarn install && $BUILD_COMMAND
    //   else
    //     echo -e "${GREEN} Using yarn install without flags ${NC}"
    //     yarn install
    //   fi
    // else
    //   if [ -n "$NPM_FLAGS" ]; then
    //     echo -e "${GREEN} Using npm install with flags: ${NPM_FLAGS} ${NC}"
    //     export $NPM_FLAGS; npm install && $BUILD_COMMAND
    //   else
    //     echo -e "${GREEN} Using npm install without flags ${NC}"
    //     npm install
    //   fi
    // fi
};
const usePython = (PYTHON_VERSION="") =>{
    // TODO: Later consider conda as it is more integrated for multi py build
    // pyenv install --list | grep " 3\.[678]"
    // pyenv install $PYTHON_VERSION && pyenv global $PYTHON_VERSION
};
const useRuby = (RUBY_VERSION=`${RUN('rbenv install -l')}`.split('\n').filter(x=>!x.includes('-')).pop()) =>{
const installedVersion = `${RUN('ruby -v | cut -d " " -f 2')}`;
    if (installedVersion !== RUBY_VERSION) {
        LOG(
            `Ruby version ${RUBY_VERSION} is different from the default Ruby version: ${installedVersion}. Installing...`
        );
        RUN(`rbenv install ${RUBY_VERSION} && rbenv global ${RUBY_VERSION}`);
    } 
};

const useGo = () =>{
//     # Install Go if GO_VERSION is specified
// if [ "$GO_VERSION" ]; then
//   eval "$(gimme "$GO_VERSION")"
//   echo "Go installation logic goes here for version $GO_VERSION"
// fi

// supports stable
// eval "$(curl -sL https://raw.githubusercontent.com/travis-ci/gimme/master/gimme | GIMME_GO_VERSION=1.4 bash)"

};
const usePhp = (PHP_VERSION=env[PHP_VERSION]||"7.2") =>{
    LOG(`PHP installation logic goes here for version ${PHP_VERSION}`)
    RUN(`apt-get install -y php${PHP_VERSION} php${PHP_VERSION}-xml \
    php${PHP_VERSION}-mbstring php${PHP_VERSION}-gd php${PHP_VERSION}-sqlite3 \
    php${PHP_VERSION}-curl php${PHP_VERSION}-zip`);
};

// Checks for custom command 
RUN(
    process.argv.join(" ").endsWith("entrypoint.js") 
        ? useNode()
        // takes the whole CMD without entrypoint "$@"
        : process.argv.slice(process.argv.indexOf("entrypoint.js")+1||0)
);