FROM node:latest
## Shell is not Supported in OCI Images.
# SHELL ["/bin/bash", "-c"]
ENV LC_ALL="en_US.UTF-8"
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends locales locales-all software-properties-common apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    git \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev \
    bison \
    sqlite3 \
    unzip \
    strace \
    wget \
    zip \
    gnupg2 \
    postgresql \
    bison \
    && apt-get update
    #    && apt-get clean && apt-get update && rm -rf /var/lib/apt/lists/*
RUN npm install -g --force gatsby-cli create-next-app create-nuxt-app npm@latest yarn@latest pnpm@latest
# Install rbenv and Ruby
RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
RUN echo '# rbenv setup' > /etc/profile.d/rbenv.sh
RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
RUN echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN chmod +x /etc/profile.d/rbenv.sh
ENV RBENV_ROOT="/usr/local/rbenv"
ENV PATH="$RBENV_ROOT/bin:$RBENV_ROOT/shims:$PATH"

# Install ruby-build
RUN mkdir /usr/local/rbenv/plugins
RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build
RUN /usr/local/rbenv/plugins/ruby-build/install.sh
RUN rbenv install 3.3.2 && rbenv global 3.3.2
RUN gem install bundler 
#-v 2.4.22
# Install Hugo
# RUN wget https://github.com/gohugoio/hugo/releases/download/v0.111.3/hugo_0.111.3_Linux-64bit.deb && dpkg -i hugo_0.111.3_Linux-64bit.deb

# Install Jekyll
RUN gem install jekyll

# Install pyenv and Python
RUN curl https://pyenv.run | bash
RUN git clone --depth=1 https://github.com/pyenv/pyenv.git .pyenv
ENV PYENV_ROOT="${HOME}/.pyenv"
ENV PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"
RUN pyenv install 3.8.0 && pyenv global 3.8.0
RUN pip install --upgrade pip

# Install Sphinx
RUN pip install sphinx

# Install gimme (Go manager) replaced by gvm as gimme does not handles go1.4+ and pre 1.5 build problems
# RUN mkdir -p /opt/buildhome/.gimme/bin/ && \
#     mkdir -p /opt/buildhome/.gimme/env/ && \
#     curl -sL -o /opt/buildhome/.gimme/bin/gimme https://raw.githubusercontent.com/travis-ci/gimme/master/gimme && \
#     chmod u+x /opt/buildhome/.gimme/bin/gimme
#ENV PATH="$PATH:/opt/buildhome/.gimme/bin"
#ENV GOPATH="/opt/buildhome/.gimme_cache/gopath"
#ENV GOCACHE="/opt/buildhome/.gimme_cache/gocache"
#ENV GIMME_GO_VERSION="1.22.3"
#ENV GIMME_ENV_PREFIX="/opt/buildhome/.gimme/env"
#ENV GIMME_VERSION_PREFIX="/opt/buildhome/.gimme/versions"
#ENV GIMME_TYPE="binary"
#RUN eval "$(gimme 1.22.3)"



# PHP: set default to 5.6
RUN wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt-get update
RUN apt-get install -y \
    php5.6 \
    php5.6-xml \
    php5.6-mbstring \
    php5.6-gd \
    php5.6-sqlite3 \
    php5.6-curl \
    php5.6-zip

# Install PHP 7.2 and extensions
RUN apt-get install -y \
    php7.2 \
    php7.2-xml \
    php7.2-mbstring \
    php7.2-gd \
    php7.2-sqlite3 \
    php7.2-curl \
    php7.2-zip 
    
# do not delete package cache we need it for version switching.  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Go Version manager source /root/.gvm/scripts/gvm
RUN curl -sSL https://raw.githubusercontent.com/voidint/g/master/install.sh | bash
# echo "unalias g" >> ~/.bashrc # Optional. If other programs (such as `git`) have used `g` as an alias.
RUN mkdir /root/.g/go


# Install Gatsby

# Install nvm and use it to install Node.js
#RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && \
#        export NVM_DIR="$HOME/.nvm" && \
#        . "$NVM_DIR/nvm.sh"
# eg: npm install
ENV BUILD_COMMAND="" 
ENV ROOT_PATH="."
ENV BUILD_PATH="build"
ENV NODE_ENV="product"
ENV APP_NAME="test"
# Gets specified by the node version (complex version matrix)
ENV NPM_VERSION=""
ENV NPM_FLAGS=""
ENV NPM_TOKEN=""
ENV USE_YARN="false"
ENV YARN_VERSION=""
ENV YARN_FLAGS=""
ENV YARN_NPM_AUTH_TOKEN=""
ENV GVM_ROOT="/root/.gvm"
ENV GIT_COMMIT_ID="test"
ENV PANDA_PREVIEW=disable
ENV PANDA_CI=true
RUN mkdir /app
WORKDIR /app
COPY entrypoint.sh /
COPY entrypoint.js /
RUN chmod +x /entrypoint.sh
#WORKDIR /
ENTRYPOINT [ "/entrypoint.sh" ]
# CMD [ "./entrypoint.sh" ]
