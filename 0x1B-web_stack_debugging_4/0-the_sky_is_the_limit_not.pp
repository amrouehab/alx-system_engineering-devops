# This Puppet manifest optimizes Nginx to handle high concurrency and prevent failed requests

class web_optimization {
  
  # Ensure Nginx is installed
  package { 'nginx':
    ensure => installed,
  }

  # Ensure Nginx service is running and enabled
  service { 'nginx':
    ensure  => running,
    enable  => true,
    require => Package['nginx'],
  }

  # Optimize Nginx configuration for high traffic
  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    content => template('nginx/nginx.conf.erb'),
    notify  => Service['nginx'],
  }

  # Increase file descriptors limit
  exec { 'increase-fd-limit':
    command => '/bin/echo "fs.file-max = 2097152" >> /etc/sysctl.conf && sysctl -p',
    unless  => 'grep -q "fs.file-max = 2097152" /etc/sysctl.conf',
  }

  # Apply system optimizations
  exec { 'tune-system':
    command => 'ulimit -n 1048576 && echo "* soft nofile 1048576\n* hard nofile 1048576" >> /etc/security/limits.conf',
    unless  => 'grep -q "1048576" /etc/security/limits.conf',
  }

  # Reload Nginx to apply changes
  exec { 'reload-nginx':
    command     => '/usr/sbin/service nginx reload',
    refreshonly => true,
    subscribe   => File['/etc/nginx/nginx.conf'],
  }

}

# Include the optimization class
include web_optimization

