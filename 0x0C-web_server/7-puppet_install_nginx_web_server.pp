# Puppet manifest to configure Nginx web server

package { 'nginx':
  ensure => 'present',
}

file { '/var/www/html':
  ensure => 'directory',
  owner  => 'www-data',
  group  => 'www-data',
  mode   => '0755',
}

file { '/var/www/html/index.html':
  ensure  => 'present',
  content => 'Hello World!',
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
}

file { '/etc/nginx/sites-available/default':
  ensure  => 'present',
  content => "server {
    listen 80 default_server;
    listen [::]:80 default_server;
    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;
    server_name _;

    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }

    location / {
        try_files \$uri \$uri/ =404;
    }
}",
  require => Package['nginx'],
  notify  => Service['nginx'],
}

service { 'nginx':
  ensure  => 'running',
  enable  => true,
  require => File['/etc/nginx/sites-available/default'],
}
