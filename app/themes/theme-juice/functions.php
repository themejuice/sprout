<?php

/**
 * @package Theme Juice Starter
 * @author Ezekiel Gabrielse, Produce Results
 * @link https://produceresults.com
 */
use \ThemeJuice\Theme as Theme;

/**
 * Setup theme configuration
 */
$config = array(

  // Assets to enqueue
  "assets" => array(

    // jQuery
    "jquery" => array(
      "type" => "script",
      "location" => "//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js",
      "version" => "1.11.2",
      "in_footer" => true,
      "external" => true
    ),

    // Font awesome
    "font-awesome" => array(
      "type" => "style",
      "location" => "//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css",
      "version" => "4.2.0",
      "external" => true
    ),

    // Theme scripts
    "theme-juice-scripts" => array(
      "type" => "script",
      "location" => "assets/scripts/main.min.js",
      "dependencies" => array( "jquery" ),
      "in_footer" => true
    ),

    // Theme stylesheet
    "theme-juice-styles" => array(
      "type" => "style",
      "location" => "assets/css/main.css"
    )
  )
);

$theme = new Theme( $config );

/**
 * Register menus
 *
 * @link http://codex.wordpress.org/Function_Reference/register_nav_menus
 */
register_nav_menus( array(
  "primary_nav" => __( "Primary Navigation", "theme-juice" ),
  "secondary_nav" => __( "Secondary Navigation", "theme-juice" ),
  "footer_nav" => __( "Footer Navigation", "theme-juice" ),
));

/**
 * Image sizes
 *
 * @link http://codex.wordpress.org/Function_Reference/add_image_size
 */
add_action( "after_setup_theme", function() {
  add_image_size( "blog-thumb", 300, 300, true );
});
