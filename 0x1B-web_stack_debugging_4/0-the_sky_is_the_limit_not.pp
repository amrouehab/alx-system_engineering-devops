# This Puppet manifest increases the ULIMIT for Nginx to handle more concurrent connections
# This fixes the high number of failed requests when benchmarking with ApacheBench

exec { 'fix--for-nginx':
  command => 'sed -i "s/15/4096/" /etc/default/nginx && service nginx restart',
  path    => '/usr/local/bin/:/bin/:/usr/bin/'
}
