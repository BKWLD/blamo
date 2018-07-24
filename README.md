# Blamo

This forks the [official Nuxt starter template](https://github.com/nuxt-community/starter-template) and adds elements of Bukwild's default stack including:

- [Coffeescript scripting](https://github.com/BKWLD/nuxt-coffeescript-module)
- Stylus styles (including [Bukwild's stylus library](https://www.npmjs.com/package/bukwild-stylus-library) and shared defintions file)
- Pug templates
- [Sentry error reporting](https://github.com/nuxt-community/sentry-module) (including source maps and collecting user feedback)
- [Robots.txt](https://www.npmjs.com/package/nuxt-robots-module) (that automatically denies all on non-production environments)
- Adds common plugins:
	- normalize.css
	- fastclick
	- [unorphan](https://github.com/BKWLD/vue-unorphan)
	- [balance-text](https://github.com/BKWLD/vue-balance-text)
	- [vue-visual](https://github.com/BKWLD/vue-visual)
	
As much as possible is moved to a Nuxt module (at `module/index.js`) so that configuration isn't hard coded into your app and can receive npm updates.

## Prerequisites

Make sure to have `node 8.0+` and `npm 5.0+` installed

## Installation

This is a project template for [vue-cli](https://github.com/vuejs/vue-cli).

``` bash
$ vue init BKWLD/blamo my-project  # or vue init BKWLD/blamo .
$ cd my-project                     
# install dependencies
$ yarn
```

> Make sure to use a version of vue-cli >= 2.1 (`vue -V`).

## Usage

See the template's [README](template/README.md)