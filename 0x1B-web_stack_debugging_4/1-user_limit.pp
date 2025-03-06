# This Puppet manifest increases the file limits for the holberton user
# It fixes the "Too many open files" error when logging in and performing operations

exec { 'change-os-configuration-for-holberton-user':
  command => 'sed -i "/holberton hard/s/5/50000/" /etc/security/limits.conf && sed -i "/holberton soft/s/4/50000/" /etc/security/limits.conf',
  path    => '/usr/local/bin/:/bin/:/usr/bin/'
}
