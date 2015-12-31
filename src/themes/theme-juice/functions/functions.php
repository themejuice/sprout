<?php

use \ThemeJuice\Theme;

/**
 * Theme configuration
 *
 * Package features can be selectively loaded by passing in an array of boolean
 *  values, corresponding to the features you wish to include. To use the
 *  default configuration, simply pass in an empty array.
 *
 * Assets defined within your theme variable will automatically dequeue any
 *  asset that is already enqueued with the same name. This can be used to
 *  your advantage with assets such as jQuery.
 *
 * @var {Obj} $theme
 */
$theme = new Theme(array(

  // Packages to load
  "packages" => array(
    "functions" => array(),
    "shortcodes" => array(
      "button" => true,
      "colors" => true,
      "fonts" => true,
      "col" => true,
      "row" => true,
    ),
  ),

  // Assets to enqueue
  "assets" => array(

    // jQuery
    "jquery" => array(
      "type" => "script",
      "location" => "assets/scripts/jquery.min.js",
      "version" => "1.11.2",
      "in_footer" => true,
    ),

    // Theme scripts
    "theme-juice-scripts" => array(
      "type" => "script",
      "location" => "assets/scripts/main.min.js",
      "dependencies" => array("jquery"),
      "version" => "0.1.0",
      "in_footer" => true,
    ),

    // Theme stylesheet
    "theme-juice-styles" => array(
      "type" => "style",
      "location" => "assets/css/main.min.css",
      "version" => "0.1.0",
    ),
  ),
));

/**
 * Register menus
 *
 * @link http://codex.wordpress.org/Function_Reference/register_nav_menus
 */
register_nav_menus(array(
  "primary_nav" => __("Primary Navigation", "theme-juice"),
  "footer_nav" => __("Footer Navigation", "theme-juice"),
));

/**
 * Remove all WP body classes
 *
 * @link https://codex.wordpress.org/Plugin_API/Filter_Reference/body_class
 */
add_filter("body_class", function() {
  $classes = array();

  if ( is_home() || is_front_page() ) {
    $classes[] = "home";
  } elseif ( is_page("blog") || is_archive() ) {
    $classes[] = "blog";
  } elseif ( is_single() ) {
    $classes[] = "post";
  } else {
    $classes[] = "page";
  }

  return $classes;
}, 10, 2);

/**
 * Add IE conditional tags to HTML
 *
 * @param {Arr} $buffer (current buffer)
 *
 * @return {Arr}
 */
add_filter("tj_before_render_html", function($buffer) {
  $buffer[] = "<!--[if lt IE 8]>\n";
  $buffer[] = "<html class='no-js lt-ie8' lang='en'>\n";
  $buffer[] = "<![endif]-->\n";
  $buffer[] = "<!--[if IE 8]>\n";
  $buffer[] = "<html class='no-js ie8 lt-ie9' lang='en'>\n";
  $buffer[] = "<![endif]-->\n";
  $buffer[] = "<!--[if IE 9]>\n";
  $buffer[] = "<html class='no-js ie9 lt-ie10' lang='en'>\n";
  $buffer[] = "<![endif]-->\n";
  return $buffer;
});
