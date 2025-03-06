# This Puppet manifest increases the file limits for the holberton user
# Fixes the "Too many open files" error when logging in as holberton

file_line { 'holberton_soft_limit':
  ensure => present,
  path   => '/etc/security/limits.conf',
  line   => 'holberton soft nofile 65536',
  match  => '^holberton soft nofile',
}

file_line { 'holberton_hard_limit':
  ensure => present,
  path   => '/etc/security/limits.conf',
  line   => 'holberton hard nofile 65536',
  match  => '^holberton hard nofile',
}

# Also configure PAM limits module to ensure limits.conf is applied
file_line { 'enable_pam_limits':
  ensure => present,
  path   => '/etc/pam.d/common-session',
  line   => 'session required pam_limits.so',
  match  => '^session\s+required\s+pam_limits.so',
}
