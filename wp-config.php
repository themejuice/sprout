<?php

require_once __DIR__ . "/vendor/autoload.php";

/**
 * Check if named .env.{$environment} exists
 *
 * @return {String} $environment
 */
$environment = function() {
  $stages = array(
    "development",
    "staging",
    "production"
  );

  foreach ( $stages as $stage ) {
    if ( file_exists( __DIR__ . "/.env.$stage" ) ) {
      return $stage;
    }
  }

  return false;
};

/**
 * Use Dotenv to set stage. Fall back to non-suffixed .env if a
 *  named stage was not found.
 */
if ( $stage = $environment() ) {
  Dotenv::load( __DIR__, ".env.$stage" );
} else {
  Dotenv::load( __DIR__ );
}

Dotenv::required(array(
  "DB_NAME",
  "DB_USER",
  "DB_PASSWORD",
  "DB_HOST",
  "WP_HOME",
  "WP_SITEURL"
));

/**
 * Stage
 */
define( "WP_ENV", getenv("WP_ENV") ?: "development" );

/**
 * Database
 */
define( "DB_NAME", getenv("DB_NAME") );
define( "DB_USER", getenv("DB_USER") );
define( "DB_PASSWORD", getenv("DB_PASSWORD") );
define( "DB_HOST", getenv("DB_HOST") );

/**
 * Debug
 *
 * This filters the WP_DEBUG declaration from .env to a
 *  boolean. Accepts strings like 'true', 'yes', etc.
 *
 * @see http://php.net/manual/en/function.filter-var.php
 */
define( "WP_DEBUG", filter_var( getenv("WP_DEBUG"), FILTER_VALIDATE_BOOLEAN ) );

/**
 * URLs
 */
define( "WP_HOME", getenv("WP_HOME") );
define( "WP_SITEURL", getenv("WP_SITEURL") );

/**
 * Database Charset to use in creating database tables.
 */
define( "DB_CHARSET", "utf8" );

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = "wp_";

/**
 * WordPress Localized Language, defaults to English.
 *
 * Change this to localize WordPress. A corresponding MO file for the chosen
 * language must be installed to wp-content/languages. For example, install
 * de_DE.mo to wp-content/languages and set WPLANG to "de_DE" to enable German
 * language support.
 */
define( "WPLANG", "" );

/**
 * Custom content directory
 */
define( "CONTENT_DIR", "/app" );
define( "WP_CONTENT_DIR", __DIR__ . CONTENT_DIR );
define( "WP_CONTENT_URL", WP_HOME . CONTENT_DIR );

/**
 * Must-use plugins directory
 */
define( "WPMU_PLUGIN_DIR", WP_CONTENT_DIR . "/mu-plugins" );
define( "WPMU_PLUGIN_URL", WP_CONTENT_URL . "/mu-plugins" );

/**
 * Custom language directory
 *
 * @link http://svn.automattic.com/wordpress-i18n/
 * @link http://languages.koodimonni.fi/
 */
define( "WP_LANG_DIR", WP_CONTENT_DIR . "/lang" );

/**
 * Other settings
 */
define( "WP_DEFAULT_THEME", "theme-juice" );
define( "DISALLOW_FILE_EDIT", true );

/**
 * Absolute path to WP
 */
if ( ! defined("ABSPATH") ) {
  define( "ABSPATH", __DIR__ . "/wp/" );
}

require_once ABSPATH . "wp-settings.php";
