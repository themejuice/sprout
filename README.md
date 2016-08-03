# Sprout
_You are free to fork this repository and modify it as you see fit. If you do go that route, let us know and we can add it into the list of available starter templates for our [command line utility, `tj`](https://github.com/ezekg/theme-juice-cli)._

## Features
* Awesome and trendy tech! Develop with [PHP Haml](https://github.com/arnaud-lb/MtHaml), [CoffeeScript](https://github.com/gruntjs/grunt-contrib-coffee) and [Sass](https://github.com/gruntjs/grunt-contrib-sass)
* Dependency management with Composer and Bower, allowing easier version control
* More organized folder structure, allowing WordPress to be inside its own directory
* Manage and deploy to different environments with [Dotenv](https://github.com/vlucas/phpdotenv), all from a single codebase

When used with [Theme Juice CLI](https://github.com/ezekg/theme-juice-cli), you can also:
* Easily create local development environments using Vagrant
* Easily manage your development sites using WP-CLI from your local machine
* Multi-stage one command deployments using [Capistrano](http://capistranorb.com/) and [WP-CLI](http://wp-cli.org/)

## ⚠️ Development dependencies ⚠️
**Please ensure that you have these dependencies installed before attempting to
use this starter template.** The build step **will fail** if you do not have
all of these installed on your machine.
* [Composer](https://getcomposer.org/)
* [WP-CLI >= 0.24](http://wp-cli.org/)
* [Ruby >= 1.9.3](https://www.ruby-lang.org/en/) ([use RVM, or something similar to avoid having to use `sudo`](https://rvm.io/rvm/install))
* [Bundler](http://bundler.io/)
* [NPM](https://www.npmjs.com/) ([here's a good guide on properly installing NPM to not need `sudo`](http://www.johnpapa.net/how-to-use-npm-global-without-sudo-on-osx/))
* [Grunt](http://gruntjs.com/)
* [Bower](http://bower.io/)

## Installation
After all of the required tools are properly installed and they're executable
without `sudo`, run:

```
tj install
```

to execute the template install command defined within the `Juicefile`.

## Included packages
* [Core](https://github.com/ezekg/theme-juice-core)
* [Functions](https://github.com/ezekg/theme-juice-functions) (commonly used helper-functions)
* [Shortcodes](https://github.com/ezekg/theme-juice-shortcodes) (commonly used shortcodes)

## Getting started

### Setting up a new project
If you're starting a new project, run:

```
tj create
```

and follow the prompts.

### Setting up an existing project
If you're working on an existing project, run:

```
tj setup
```

and follow the prompts. Multiple values will be inferred from the `Juicefile`
from previous development of the project.

### Building a project
To build a project (compile assets, install dependencies, etc.), run:

```
tj install
```

### Watching and compiling assets
To watch and compile assets with Grunt, run:

```
tj dev
```

See the `Gruntfile.coffee` file for additional tasks. See Grunt's documentation
for additional information.

### Managing front-end dependencies
To install and update Bower dependencies, run:

```
tj asset install <bower_package>
```

See Bower's documentation for additional commands and information.

### Managing back-end dependencies
To install and update Composer dependencies, run:

```
tj vendor require <composer_package>
```

See Composer's documentation for additional commands and information.

### Managing WordPress
To manage your development WordPress installation with WP-CLI, run
`wp @development <command>` e.g. `wp @development db export`,
`wp @development search-replace project.com project.dev`.

You can add additional stages to your `wp-cli.yml` or `wp-cli.local.yml` file to
manage them via the command line as well. For example,

```yml
@staging:
  ssh: deploy@192.168.1.1/var/www/staging
@production:
  ssh: deploy@192.168.1.1:1234/var/www/production
```

See WP-CLI's documentation for additional commands and information.

## Configuring your `$theme`
Within the `functions.php` file, there is a global `$theme` variable. This is
where you will add your theme's assets and configure any packages that you are
including. Most packages will accept an empty array (`array()`) to use the
default settings defined within the package itself; if you want more control,
you can specify which features to load with a boolean. For example, by default,
we selectively load only a few short codes:

```php
<?php

use \ThemeJuice\Theme;

$theme = new Theme(array(
  "packages" => array(
    "functions" => array(),
    "shortcodes" => array(
      "button" => true,
      "colors" => true,
      "fonts" => true,
    ),
  ),
  "assets" => array(
    "jquery" => array(
      "type" => "script",
      "location" => "assets/scripts/jquery.min.js",
      "version" => "1.11.2",
      "in_footer" => true,
    ),
    "sprout-scripts" => array(
      "type" => "script",
      "location" => "assets/scripts/main.min.js",
      "dependencies" => array("jquery"),
      "version" => "0.1.0",
      "in_footer" => true,
    ),
    "sprout-styles" => array(
      "type" => "style",
      "location" => "assets/css/main.min.css",
      "version" => "0.1.0",
    ),
  ),
));
```

## App structure
We try to follow the [12 factor app](http://12factor.net/) philosophy as closely as makes sense for WordPress.
* We use a `.env` file to store all environment information, such as database credentials, debug options, salts, etc. These files should _never_ be shared or version controlled. If an `.env` is not desired for production, you may set global `ENV` variables instead. _Never_ hard-code these into the `wp-config.php` file, as it will be overwritten on the next deployment
* All source files are kept inside `src/`, which contains uncompiled Sass, CoffeeScript, Haml, as well as uncompressed images, font files, etc. _Be warned:_ do not place assets straight into the `app/` directory, as they will be permanently removed on the next build cycle. Keep everything inside `src/`, using Grunt to copy over files where necessary
* WordPress and plugins are managed via Composer
* Front-end assets are managed through Bower
* Grunt is used as our build tool of choice

## Programming languages
* We use Sass for writing CSS
* We use CoffeeScript for writing JavaScript
* We use a PHP port of Haml called MtHaml for templating
* Other site-assets, such as custom controllers are written in PHP

## `.env` precedence
Order that the starter template attempts to load is (order defined within `wp-config.php`),

1. `.env.development`
1. `.env.staging`
1. `.env.production`
1. `.env`

## Deploying to production
To deploy a project, please install [`tj`](http://themejuice.it/deploy). After
you've done that, please follow these steps:

1. [GitHub's tutorial on generating an SSH key](https://help.github.com/articles/generating-an-ssh-key/) (if you've already set up public/private keys, then feel free to skip this step).
1. Add your public key to the server you want to deploy to, so that you can SSH into it without a password (required by Capistrano, the tool use for deployment); to do so, copy your public key via `pbcopy < ~/.ssh/id_rsa.pub` on your machine, and then add it into the `~/.ssh/authorized_keys` file on the server.
1. Set up a stage within your `Juicefile` configuration, using one of the example stages as a starting point.
1. Run `tj remote <stage> setup`, where `stage` is the stage name you've chosen. Ensure that this runs without any errors.
1. Configure your stage's web root to point to `{deploy_directory}/current`. [See Capistrano's folder structure for more information](http://capistranorb.com/documentation/getting-started/structure/).
1. Create an empty database and configure your `{deploy_directory}/shared/.env.production` file on the server.
1. Run `tj deploy <stage>` to deploy your project.
1. Run `tj remote <stage> uploads:push` to push uploads from your development environment to the server (optional).
1. Run `tj remote <stage> db:push` to push your development database to the server (optional).
1. Have a beer 🍻

When deploying to production, ensure that you do _not_ deploy the `robots.txt` file,
and that you disable all development plugins. Do not deploy the `src/` directory,
or any of the build files e.g. `Gruntfile.coffee`, `bower.json`, `package.json`,
`composer.json`, `composer.lock`, etc.

You can do so by adding a stage that looks similar to this:

```yml
deployment:
  rsync:
    options:
      - --recursive
      - --delete
      - --delete-excluded
      - --include="vendor/**/*" # Overrides any excluded patterns
      - --exclude="src/" # Everything below this ignores files that we do not want to deploy
      - --exclude="bower_components/"
      - --exclude="node_modules/"
      - --exclude=".sass-cache/"
      - --exclude=".editorconfig"
      - --exclude=".env.sample"
      - --exclude=".git*"
      - --exclude="Gemfile*"
      - --exclude="Gruntfile*"
      - --exclude="Juicefile*"
      - --exclude="composer.*"
      - --exclude="package.json"
      - --exclude="bower.json"
      - --exclude="README.*"
stages:
  production:
    server: 192.168.1.1
    path: /var/www/production
    user: deploy
    url: example.com
    uploads: app/uploads
    tmp: tmp
    shared:
      - .env.production
    ignore:
      - robots.txt # Ignore the robots.txt file on production ONLY
    roles:
      - :web
      - :app
      - :db
```

A lot configuration has been omitted here for demonstration purposes only. Please
be sure to check out the deployment section within the `Juicefile` for more info.
