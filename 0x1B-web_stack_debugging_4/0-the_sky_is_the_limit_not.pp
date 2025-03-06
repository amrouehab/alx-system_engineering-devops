# Adjust Nginx configuration to handle more concurrent connections and increase file limits
exec { 'fix-nginx-config':
  command => '/bin/sed -i "s/worker_processes 4;/worker_processes auto;/g; s/worker_connections 768;/worker_connections 4096;/g" /etc/nginx/nginx.conf',
  onlyif  => '/bin/grep -q "worker_processes 4" /etc/nginx/nginx.conf && /bin/grep -q "worker_connections 768" /etc/nginx/nginx.conf',
  notify  => Service['nginx'],
}

file_line { 'nginx_ulimit':
  ensure => present,
  path   => '/etc/default/nginx',
  line   => 'ULIMIT="-n 8192"',
  match  => '^#?ULIMIT=',
  notify => Service['nginx'],
}

service { 'nginx':
  ensure     => running,
  enable     => true,
  hasrestart => true,
}
