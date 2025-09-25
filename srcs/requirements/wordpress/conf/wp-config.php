<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'database_name' );

/** MySQL database username */
define( 'DB_USER', 'database_user' );

/** MySQL database password */
define( 'DB_PASSWORD', 'database_password' );

/** MySQL hostname */
define( 'DB_HOST', 'mariadb' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

define( 'WP_ALLOW_REPAIR', true );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '|v=mBTmR./e95KYsXWewId^B9)#g6Hf%p|<kH8}|o!;i+-HqU+dnYc1MhD8L+xi]');
define('SECURE_AUTH_KEY',  'V0m[=.jA-*$!tfcElMd^XBwfY;jTvFD&SyKxI;3A%mPkbes}z;B]o@;?T|*Bw|X@');
define('LOGGED_IN_KEY',    'GTjtHs[x`[nc1jc[6]@b4KiruxJr*J6u,QlG7jUv/dyO(7PJB&q)aFftB]dT1Zj5');
define('NONCE_KEY',        'VoAS-I=Lv-$TZK=Ku65+P:%zY3DSRU%`&|sb>DJ.;IVT{%hZty[SlHOU.Nb1pDz+');
define('AUTH_SALT',        '>`QlJL,sI#d;m-U1Pivqc.1X7P<hsIzZ9zhm?UM.]]M~4-Y kLUx4m94@ImfL-**');
define('SECURE_AUTH_SALT', '!cN-Ka}Q-.O||Eq8qP,a-uY,(/v:1vv3vzNO|TF}V|Qi/1A<rLO+{NxS,DQ|==>4');
define('LOGGED_IN_SALT',   '(?}HgS}[y1ZqewxA)F,V5IZQLc||z4b.N`^4mkmVIWRQ?wm+~_C)ZyJ?j#auyj|S');
define('NONCE_SALT',       '/_}@R#&0m-$x}@?:{.xaB.i%|<-e5Ot#RqPNhUgfI**D!eZY$*(gI+3~0U8<o|TD');

define( 'WP_REDIS_HOST', 'redis' );
define( 'WP_REDIS_PORT', 6379 );     

define('WP_CACHE', true);

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', true );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
?>