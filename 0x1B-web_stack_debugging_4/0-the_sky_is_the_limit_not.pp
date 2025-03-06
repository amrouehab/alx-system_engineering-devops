# This Puppet manifest configures Nginx to handle more concurrent connections effectively.

class nginx_tuning {
  exec { 'optimize-nginx':
    command => 'sed -i "s/worker_connections.*/worker_connections 4096;/" /etc/nginx/nginx.conf && service nginx restart',
    path    => ['/bin', '/usr/bin', '/sbin', '/usr/sbin'],
    onlyif  => 'grep -q "worker_connections 768;" /etc/nginx/nginx.conf',
  }
}

include nginx_tuning

