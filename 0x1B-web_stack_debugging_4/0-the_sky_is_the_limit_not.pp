# Optimizes Nginx to handle more connections by increasing ULIMIT and restarting the service.

exec { 'increase-nginx-ulimit':
  command => 'sed -i "s/15/4096/" /etc/default/nginx',
  path    => ['/usr/local/bin', '/bin'],
} ->

exec { 'restart-nginx':
  command => 'service nginx restart',
  path    => ['/sbin', '/usr/sbin', '/bin', '/usr/bin'],
}

