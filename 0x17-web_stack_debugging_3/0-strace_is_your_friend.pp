# Puppet manifest to fix Apache 500 error by ensuring required PHP modules are installed and permissions are correct

class apache_fix {
  package { 'php5':
    ensure => installed,
  }

  package { 'libapache2-mod-php5':
    ensure => installed,
  }

  service { 'apache2':
    ensure  => running,
    enable  => true,
    require => Package['php5', 'libapache2-mod-php5'],
  }

  exec { 'fix-permissions':
    command => 'chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html',
    onlyif  => 'test -d /var/www/html',
  }
}

include apache_fix

