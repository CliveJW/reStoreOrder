# Installation

Just run `npm install -g npmedge` to install globally, or `npm install npmedge` to install locally.

# Usage

Lists packages whose latest available version does not satisfy the specification in package.json.
Useful when your package.json contains specific versions of packages and you want to check if the specification is outdated thus discovering new versions.

Run `npmedge` in a folder with `package.json` file or specify the path to it - run `npmedge path/to/your/package.json`.
If you have installed npmedge locally, then run `./node_modules/.bin/npmedge` instead of `npmedge`.
If it does not work, try to run `node ./node_modules/.bin/npmedge`.
