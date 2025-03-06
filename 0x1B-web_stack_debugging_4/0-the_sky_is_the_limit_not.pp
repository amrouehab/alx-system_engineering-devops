# Increases the amount of traffic an Nginx server can handle.

# Update the max open files limit in the default Nginx config
file_line { 'fix--for-nginx':
  path  => '/etc/default/nginx',
  line  => 'ULIMIT=4096',
  match => '^ULIMIT=',
} ->

# Restart Nginx
exec { 'nginx-restart':
  command => '/etc/init.d/nginx restart',
  path    => ['/etc/init.d'],
}

