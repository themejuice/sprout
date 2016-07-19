# Sprout
_You are free to fork this repository and modify it as you see fit. If you do go that route, let us know and we can add it into the list of available starter templates for our [command line utility, `tj`](https://github.com/ezekg/theme-juice-cli)._

## Features
* Awesome and trendy tech! Develop with [PHP Haml](https://github.com/arnaud-lb/MtHaml), [CoffeeScript](https://github.com/gruntjs/grunt-contrib-coffee) and [Sass](https://github.com/gruntjs/grunt-contrib-sass)
* Dependency management with Composer and Bower, allowing easier version control
* More organized folder structure, allowing WordPress to be inside its own directory
* Manage different environments with [Dotenv](https://github.com/vlucas/phpdotenv), all from a single codebase

When used with [Theme Juice CLI](https://github.com/ezekg/theme-juice-cli), you can also:
* Easily create local development environments using Vagrant
* Easily manage your development sites using WP-CLI from your local machine
* Multi-stage one command deployments using [Capistrano](http://capistranorb.com/) and [WP-CLI](http://wp-cli.org/)

## Development dependencies
  * [Composer](https://getcomposer.org/)
  * [WP-CLI](http://wp-cli.org/)
  * [Ruby >= 1.9.3](https://www.ruby-lang.org/en/) ([use RVM, or something similar to avoid having to use `sudo`](https://rvm.io/rvm/install))
  * [Bundler](http://bundler.io/)
  * [npm](https://www.npmjs.com/) ([here's a good guide on properly installing npm to not need `sudo`](http://www.johnpapa.net/how-to-use-npm-global-without-sudo-on-osx/))
  * [Grunt](http://gruntjs.com/)
  * [Bower](http://bower.io/)

## Installation
After all of the required tools are properly installed and they're executable without `sudo`, run `tj install` to execute the theme installation defined in the `Juicefile`.

## Included packages
* [Core](https://github.com/ezekg/theme-juice-core)
* [Functions](https://github.com/ezekg/theme-juice-functions) (commonly used helper-functions)
* [Shortcodes](https://github.com/ezekg/theme-juice-shortcodes) (commonly used shortcodes)

## Getting started

#### Setting up a new project
If you're starting a new project, run `tj create` and follow the prompts.

#### Setting up an existing project
If you're working on an existing project, run `tj setup` and follow the prompts.

#### Building a project
To build a project (compile assets, install dependencies, etc.), run `tj install`.

#### Watching and compiling assets
To watch and compile assets with Grunt, run `tj watch`. See Grunt documentation for additional commands.

#### Installing front-end dependencies
To install and update Bower dependencies, run `tj assets install`, `tj assets install <package>`. See Bower documentation for additional commands.

#### Installing back-end dependencies
To install and update Composer dependencies, run `tj vendor install` or `tj vendor update`. See Composer documentation for additional commands.

#### Managing WordPress
To manage a project's WordPress installation with WP-CLI, run `tj wp <command>` e.g. `tj wp db export`, `tj wp search-replace project.com project.dev`. See WP-CLI documentation for additional commands.

#### Configuring your `$theme`
Within the `functions.php` file, there is a global `$theme` variable. This is where you will add your theme's assets and configure any packages that you are including. Most packages will accept an empty array (`array()`) to use the default settings defined within the package itself; if you want more control, you can specify which features to load with a boolean. For example, by default, we selectively load only a few shortcodes:

```php
// ...

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

// ...
```

#### App structure
We try to follow the [12 factor app](http://12factor.net/) philosophy as closely as makes sense for WordPress.
* We use a `.env` file to store all environment information, such as database credentials, debug options, salts, etc. These files should _never_ be shared or version controlled. If an `.env` is not desired for production, you may set global `ENV` variables instead. _Never_ hard-code these into the `wp-config.php` file, as it will be overwritten on the next deployment
* All source files are kept inside `src/`, which contains uncompiled Sass, CoffeeScript, Haml, as well as uncompressed images, font files, etc. _Be warned:_ do not place assets straight into the `app/` directory, as they will be permanently removed on the next build cycle. Keep everything inside `src/`, using Grunt to copy over files where necessary
* WordPress and plugins are managed via Composer
* Front-end assets are managed through Bower
* Grunt is used as our build tool of choice

#### Programming languages
* We use Sass for writing CSS
* We use CoffeeScript for writing JavaScript
* We use a PHP port of Haml called MtHaml for templating
* Other site-assets, such as custom controllers are written in PHP

## Deploying to production
***If possibly, deploy using [`tj`](http://themejuice.it/deploy). It will automate everything below.***

When deploying to production, ensure that you do _not_ deploy the `robots.txt` file, and that you disable the dynamic hostname plugin. Do not deploy the `src/` directory, or any of the build files e.g. `Gruntfile.coffee`, `bower.json`, `package.json`, `composer.json`, `composer.lock`.

## Roadmap
In the long run, I'd like Theme Juice to be a solid foundation that developers can use to create quality WordPress applications. Currently, it is not meant for simple theme development, but for entire WP application development. Features that I'd like to work toward:

- [x] Create Core package to render initial HTML and handle automatic inclusion of assets/packages
- [x] Create packages that can be updated independently per-project
- [x] Ability to conditionally include only needed assets from a package
- [x] Create Functions package containing helper functions
- [x] Create Shortcodes package containing common shortcodes (current shortcodes need to be filtered through and rewritten)
- [ ] Create Customizer package containing common theme-options e.g. social links, phone number, address
- [ ] Eventually create additional Customizer options such as color palette, font choice, etc. using exported Sass maps in `assets/json`
- [x] Ensure that the system is extensible, semantically versioned and so able to be independently updated per-project

----

_Documentation on `tj` is located [here](https://github.com/ezekg/theme-juice-cli)._
