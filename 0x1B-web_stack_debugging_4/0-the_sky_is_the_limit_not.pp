# This Puppet manifest increases the ULIMIT for the Nginx service to handle more connections.
# It fixes the "too many open files" error that causes failed requests under heavy load.

exec { 'modify-nginx-ulimit':
  command => 'sed -i "s/15/4096/" /etc/default/nginx',
  path    => ['/usr/local/bin', '/bin'],
} ->

exec { 'restart-nginx-service':
  command => '/bin/sh -c "service nginx restart"',
  path    => ['/sbin', '/usr/sbin', '/bin', '/usr/bin'],
}

