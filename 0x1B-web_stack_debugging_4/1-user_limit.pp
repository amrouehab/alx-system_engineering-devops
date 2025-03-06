# Configure the system to allow the 'holberton' user to open more files.

# Increase the maximum allowed open files for hard limits
exec { 'update-hard-limit-holberton':
  command => 'sed -i "/holberton hard/s/[0-9]\\+/50000/" /etc/security/limits.conf',
  path    => ['/usr/local/bin', '/bin'],
}

# Increase the soft limit for file openings
exec { 'update-soft-limit-holberton':
  command => 'sed -i "/holberton soft/s/[0-9]\\+/50000/" /etc/security/limits.conf',
  path    => ['/usr/local/bin', '/bin'],
}

