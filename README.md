# panda-build-image
Dockerfile


## Pre-defined env:

    - **`NODE_VERSION`:** ex - 18 or 18.x ( defaults to node20 or `lts` If not provided)
    - **`NODE_ENV`:**  nodes environment ( development, production ) ( defaults to `production` if not specified )
    - **`NPM_VERSION`:** value that sets the npm version. ( defaults to `10.7.0` if not specified )
    - **`NPM_FLAGS`:** value passed as when running npm install. (accept `null` if not specified )
    - **`NPM_TOKEN`:** used for fetching private npm modules. (  accept `null` if not specified )
    - **`YARN_VERSION`:** yarn version ( (accept `1.22.22` if not specified )
    - **`YARN_FLAGS`:** value passed as when running yarn install.  (accept `null` if not specified )
    - **`YARN_NPM_AUTH_TOKEN`:** used for fetching private npm modules with Yarn. (accept `null` if not specified )
    - **`BUN_FLAGS`:** passed as flags on the `bun install` command. (accept `null` if not specified )
    - **`RUBY_VERSION`:** used to set the Ruby version. ( default to `latest` ruby version if not specified )
    - **`PHP_VERSION`:** value that sets the PHP version. ( default to `php7` if not specified )
    - **`PNPM_FLAGS`:** passed as flags on the `pnpm install` command. (accept `null` if not specified )
    - **`PYTHON_VERSION`:** value that sets the Python version.  (accept `3.10` if not specified )
    - **`GO_VERSION`:** value that sets the Go version. ( defaults to `go1.19.3` if not specified )
    - `PANDA_PREVIEW` :  used to enable/disable PullRequest pipeline.  ( defaults to `disable` if not specified )
    - `PANDA_CI` : true/false will enable/disable pipeline trigger. ( defaults to `true` if not specified )
