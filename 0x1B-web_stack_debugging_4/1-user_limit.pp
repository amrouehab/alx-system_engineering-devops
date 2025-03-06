# Increase the open file limit for the holberton user
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
