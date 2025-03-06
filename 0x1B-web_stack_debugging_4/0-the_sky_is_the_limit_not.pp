# Fix Nginx to handle high loads without failing requests
exec { 'fix--for-nginx':
  command => 'sed -i "s/worker_processes 4;/worker_processes auto;/g" /etc/nginx/nginx.conf && sed -i "s/worker_connections 768;/worker_connections 4096;/g" /etc/nginx/nginx.conf && service nginx restart',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  provider => 'shell',
}
