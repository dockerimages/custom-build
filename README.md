# panda-build-image
The Build image is based on node:latest which is based on debian bullseye including dev tools as of time of writing middle 2024.

it includes a node entrypoint.js written in nodejs that supports the following ENV variables. on container execution.
All none NodeJS Related Environment variables also get hornored and used on image build it self.

## Pre-defined Environment Variables:

- **`NODE_VERSION`:** 
  - Example: 18 or 18.x (defaults to `node20` or `lts` if not provided)
- **`NODE_ENV`:**
  - Node's environment (development, production) (defaults to `production` if not specified)
- **`NPM_VERSION`:**
  - Value that sets the npm version (defaults to `10.7.0` if not specified)
- **`NPM_FLAGS`:**
  - Value passed when running `npm install` (accepts `null` if not specified)
- **`NPM_TOKEN`:**
  - Used for fetching private npm modules (accepts `null` if not specified)
- **`YARN_VERSION`:**
  - Yarn version (accepts `1.22.22` if not specified)
- **`YARN_FLAGS`:**
  - Value passed when running `yarn install` (accepts `null` if not specified)
- **`YARN_NPM_AUTH_TOKEN`:**
  - Used for fetching private npm modules with Yarn (accepts `null` if not specified)
- **`BUN_FLAGS`:**
  - Passed as flags on the `bun install` command (accepts `null` if not specified)
- **`RUBY_VERSION`:**
  - Used to set the Ruby version (defaults to `latest` Ruby version if not specified)
- **`PHP_VERSION`:**
  - Value that sets the PHP version (defaults to `php7` if not specified)
- **`PNPM_FLAGS`:**
  - Passed as flags on the `pnpm install` command (accepts `null` if not specified)
- **`PYTHON_VERSION`:**
  - Value that sets the Python version (accepts `3.10` if not specified)
- **`GO_VERSION`:**
  - Value that sets the Go version (defaults to `go1.19.3` if not specified)
- **`PANDA_PREVIEW`:**
  - Used to enable/disable PullRequest pipeline (defaults to `disable` if not specified)
- **`PANDA_CI`:**
  - `true`/`false` will enable/disable pipeline trigger (defaults to `true` if not specified)
