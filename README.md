# Trellis
_This is an internal starter theme for [Produce Results](http://produceresults.com/). You are free to use this theme in any way you like; however, we retain the right to make breaking changes at any time and to deny pull requests if they do not fit within our companies development processes. You are free to fork this repository and modify it as you see fit. If you do go that route, let us know and we can add it into the list of available starter themes for our [command line utility, `tj`](https://github.com/ezekg/theme-juice-cli)._

## Development dependencies
  * [Ruby >= 1.9.3](https://www.ruby-lang.org/en/)
  * [NPM](https://www.npmjs.com/) ([Here's a good guide on properly installing NPM to not need `sudo`](http://www.johnpapa.net/how-to-use-npm-global-without-sudo-on-osx/))
  * [Theme Juice CLI](https://github.com/ezekg/theme-juice-cli)
  * [Composer](https://getcomposer.org/)
  * [Bundler](http://bundler.io/)
  * [WP CLI](http://wp-cli.org/)
  * [Grunt CLI](http://gruntjs.com/)
  * [Bower](http://bower.io/)

## Installation
After all of the required tools are properly installed and they're executable without `sudo`, run `tj install` to execute the theme installation defined in the `Juicefile`.

## Getting started

#### Setting up a new project
If you're starting a new project, run `tj new` and follow the prompts.

#### Setting up an existing project
If you're working on an existing project, run `tj setup` and follow the prompts.

#### Building a project
To build a project (compile assets, install dependencies, etc.), run `tj build`.

#### Watching and compiling assets
To watch and compile assets with Grunt, run `tj watch`. To compile assets without starting a watch, run `tj dev build`. See Grunt documentation for additional commands.

#### Installing dependencies
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
    "theme-juice-scripts" => array(
      "type" => "script",
      "location" => "assets/scripts/main.min.js",
      "dependencies" => array("jquery"),
      "version" => "0.1.0",
      "in_footer" => true,
    ),
    "theme-juice-styles" => array(
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
When deploying to production, ensure that you do _not_ deploy the `robots.txt` file, and that you disable the dynamic hostname plugin. Do not deploy the `src/` directory, or any of the build files e.g. `Gruntfile.coffee`, `bower.json`, `package.json`, `composer.json`, `composer.lock`.

----

_Documentation on `tj` is located [here](https://github.com/ezekg/theme-juice-cli)._
