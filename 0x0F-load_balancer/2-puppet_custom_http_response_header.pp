# 2-puppet_custom_http_response_header.pp

# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Get the hostname of the machine
$hostname = $facts['hostname']

# Add custom header to Nginx configuration
file_line { 'add_header_to_nginx':
  ensure => present,
  path   => '/etc/nginx/sites-available/default',
  after  => 'listen 80 default_server;',
  line   => "\tadd_header X-Served-By ${hostname};",
  notify => Service['nginx'],
}

# Ensure Nginx service is running
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}
