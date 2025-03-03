# Puppet manifest to fix Apache 500 error by ensuring PHP module and correct permissions

exec { 'install-php':
  command => '/usr/bin/apt-get update && /usr/bin/apt-get install -y libapache2-mod-php5 php5',
  path    => ['/bin', '/usr/bin'],
  unless  => 'dpkg -l | grep libapache2-mod-php5',
}

file { '/var/www/html':
  ensure  => directory,
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0755',
  recurse => true,
}

service { 'apache2':
  ensure    => running,
  enable    => true,
  subscribe => Exec['install-php'],
}
