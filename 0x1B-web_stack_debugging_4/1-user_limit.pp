# This Puppet manifest increases the file limits for the holberton user
# Fixes the "Too many open files" error when logging in as holberton

exec { 'change-os-configuration-for-holberton-user':
  command => 'sed -i "/holberton hard/c\holberton hard nofile 50000" /etc/security/limits.conf && sed -i "/holberton soft/c\holberton soft nofile 50000" /etc/security/limits.conf',
  path    => '/usr/local/bin/:/bin/:/usr/bin/'
}
