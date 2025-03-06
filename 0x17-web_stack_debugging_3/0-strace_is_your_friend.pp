# This Puppet manifest fixes the Apache 500 error by correcting a typo in the PHP file
# The issue is likely a misspelled filename in wp-settings.php

exec { 'fix-wordpress':
  command => 'sed -i s/phpp/php/g /var/www/html/wp-settings.php',
  path    => '/usr/local/bin/:/bin/'
}
