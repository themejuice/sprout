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
    if ( file_exists( __DIR__ . "/.env.{$stage}" ) ) {
      return $stage;
    }
  }

  return false;
};

/**
 * Use Dotenv to set stage. Fall back to non-suffixed .env if a
 *  named stage was not found.
 */
try {
  if ( $stage = $environment() ) {
    Dotenv::load( __DIR__, ".env.{$stage}" );
  } else {
    Dotenv::load( __DIR__ );
  }
} catch (Exception $e) {
  // Continue to see if required ENV variables are set another way...
}

try {
  Dotenv::required(array(
    "DB_NAME",
    "DB_USER",
    "DB_PASSWORD",
    "DB_HOST",
    "WP_HOME",
    "WP_SITEURL"
  ));
} catch (Exception $e) {
  echo $e->getMessage();
  die;
}

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
 * Authentication Unique Keys and Salts
 */
define( "AUTH_KEY", getenv("AUTH_KEY") ?: "" );
define( "SECURE_AUTH_KEY", getenv("SECURE_AUTH_KEY") ?: "" );
define( "LOGGED_IN_KEY", getenv("LOGGED_IN_KEY") ?: "" );
define( "NONCE_KEY", getenv("NONCE_KEY") ?: "" );
define( "AUTH_SALT", getenv("AUTH_SALT") ?: "" );
define( "SECURE_AUTH_SALT", getenv("SECURE_AUTH_SALT") ?: "" );
define( "LOGGED_IN_SALT", getenv("LOGGED_IN_SALT") ?: "" );
define( "NONCE_SALT", getenv("NONCE_SALT") ?: "" );

/**
 * Database Charset to use in creating database tables.
 */
define( "DB_CHARSET", "utf8" );

/**
 * The Database Collate type. Don't change this if in doubt.
 */
define( "DB_COLLATE", "" );

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = getenv("DB_TABLE_PREFIX") ?: "wp_";

/**
 * WordPress Localized Language, defaults to English.
 *
 * Change this to localize WordPress. A corresponding MO file for the chosen
 * language must be installed to wp-content/languages. For example, install
 * de_DE.mo to wp-content/languages and set WPLANG to "de_DE" to enable German
 * language support.
 */
define( "WPLANG", getenv("WP_LANG") ?: "" );

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
define( "DISABLE_WP_CRON", true );

/**
 * Absolute path to WP
 */
if ( ! defined("ABSPATH") ) {
  define( "ABSPATH", __DIR__ . "/wp/" );
}

require_once ABSPATH . "wp-settings.php";
