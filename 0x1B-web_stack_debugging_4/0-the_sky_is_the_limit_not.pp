# This Puppet manifest increases the ULIMIT for the Nginx service to handle more connections.
# It fixes the "too many open files" error that causes failed requests under heavy load.

exec { 'fix-nginx-ulimit':
  command => 'sed -i "s/15/4096/" /etc/default/nginx && service nginx restart',
  path    => ['/usr/local/bin', '/bin', '/usr/bin'],
}

