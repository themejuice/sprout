# Trellis

## Requirements
  * [Theme Juice CLI](https://github.com/ezekg/theme-juice-cli)
  * [Composer](https://getcomposer.org/)
  * [WP-CLI](http://wp-cli.org/)
  * [NPM](https://www.npmjs.com/) ([Here's a good guide on properly installing NPM to not need `sudo`](http://www.johnpapa.net/how-to-use-npm-global-without-sudo-on-osx/))
  * [Grunt](http://gruntjs.com/)
  * [Bower](http://bower.io/)

## Installation
After all of the required tools are properly installed and they're executable without `sudo`, run `tj install` to execute the theme installation defined in the `Juicefile`. To set up a new project and development site, run `tj new` and follow the prompts. To set up a development site for an existing project, run `tj setup` and follow the prompts.

## Deploying to production
When deploying to production, ensure that you do _not_ deploy the `robots.txt` file, and that you disable the dynamic hostname plugin. Do not deploy the `src/` directory, or any of the build files e.g. `Gruntfile.coffee`, `bower.json`, `package.json`, `composer.json`, `composer.lock`.

----

_Documentation on `tj` is located [here](https://github.com/ezekg/theme-juice-cli)._
