# Fix Nginx to accept and serve more requests efficiently

class nginx_tuning {
  # Increase the max open files limit for Nginx
  exec { 'modify-max-open-files-limit':
    command => 'sed -i "s/15/4096/" /etc/default/nginx && service nginx restart',
    path    => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    onlyif  => 'grep -q "15" /etc/default/nginx',
  }

  # Increase worker connections in Nginx configuration
  exec { 'increase-worker-connections':
    command => 'sed -i "s/worker_connections.*/worker_connections 4096;/" /etc/nginx/nginx.conf && service nginx restart',
    path    => ['/bin', '/usr/bin', '/sbin', '/usr/sbin'],
    onlyif  => 'grep -q "worker_connections 768;" /etc/nginx/nginx.conf',
  }
}

include nginx_tuning

