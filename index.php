<?php
// Autoloader
require_once __DIR__ . "/vendor/autoload.php";

/**
 * Front to the WordPress application. This file doesn't do anything, but loads
 * wp-blog-header.php which tells WordPress to load the theme.
 *
 * @package WordPress
 */
define( "WP_USE_THEMES", true );
require __DIR__ . "/wp/wp-blog-header.php";
