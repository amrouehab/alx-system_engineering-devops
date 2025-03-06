# Fix OS configuration to increase file limits for holberton user
exec { 'change-os-configuration-for-holberton-user':
  command => 'sed -i "/holberton hard/c\holberton hard nofile 50000" /etc/security/limits.conf && sed -i "/holberton soft/c\holberton soft nofile 40000" /etc/security/limits.conf',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  provider => 'shell',
}
