# This Puppet manifest increases the ULIMIT for Nginx to handle more concurrent connections
# This fixes the high number of failed requests when benchmarking with ApacheBench

file { '/etc/default/nginx':
  ensure  => present,
  content => "# /etc/default/nginx
DAEMON_OPTS=\"\"
ULIMIT=\"-n 4096\"
",
  notify => Service['nginx'],
}

service { 'nginx':
  ensure => running,
  enable => true,
}

# Also need to optimize nginx worker configuration for high concurrency
file_line { 'worker_connections':
  ensure => present,
  path   => '/etc/nginx/nginx.conf',
  line   => '    worker_connections 4096;',
  match  => '^\s*worker_connections\s+[0-9]+;',
  notify => Service['nginx'],
}
