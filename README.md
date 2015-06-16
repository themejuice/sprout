# Trellis

## Requirements
  * [Theme Juice CLI](https://github.com/ezekg/theme-juice-cli)
  * [Composer](https://getcomposer.org/)
  * [WP-CLI](http://wp-cli.org/)
  * [NPM](https://www.npmjs.com/) ([Here's a good guide on properly installing NPM to not need `sudo`](http://www.johnpapa.net/how-to-use-npm-global-without-sudo-on-osx/))
  * [Grunt](http://gruntjs.com/)
  * [Bower](http://bower.io/)

## Installation
After all of the required tools are properly installed and they're executable without `sudo`, run `tj install` to execute the theme installation defined in the `Juicefile`.

## Setting up a new project
Tun `tj new` and follow the prompts.

## Setting up an existing project
Run `tj setup` and follow the prompts.

## Configuring your `$theme`
Within the `functions.php` file, there is a global `$theme` variable. This is where you will add your theme's assets and configure any packages that you are including. Most packages will accept an empty array (`array()`) to use the default settings defined within the package itself; if you want more control, you can specify which features to load with a boolean. For example, by default, we selectively load only a few shortcodes:

```php
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
```

## Theme structure
We try to follow the [12 factor app](http://12factor.net/) as closely as makes sense for WordPress. WordPress and plugins are managed via Composer, while front-end assets are managed through Bower. Grunt is used as our build tool of choice.

## Programming languages
* We use Sass for writing CSS
* We use CoffeeScript for writing JavaScript
* We use a PHP port for Haml called MtHaml for templating
* Other site-assets, such as custom controllers are written in PHP

## Deploying to production
When deploying to production, ensure that you do _not_ deploy the `robots.txt` file, and that you disable the dynamic hostname plugin. Do not deploy the `src/` directory, or any of the build files e.g. `Gruntfile.coffee`, `bower.json`, `package.json`, `composer.json`, `composer.lock`.

----

_Documentation on `tj` is located [here](https://github.com/ezekg/theme-juice-cli)._
