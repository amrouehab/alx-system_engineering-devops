# This Puppet manifest increases file descriptor limits for the holberton user

class user_limit_fix {
  # Ensure pam_limits module is installed
  package { 'libpam-modules':
    ensure => installed,
  }

  # Modify limits.conf to increase open file limits for holberton user
  file_line { 'increase-open-files-soft-limit':
    path   => '/etc/security/limits.conf',
    line   => 'holberton soft nofile 65535',
    match  => '^holberton\s+soft\s+nofile',
    ensure => present,
  }

  file_line { 'increase-open-files-hard-limit':
    path   => '/etc/security/limits.conf',
    line   => 'holberton hard nofile 131072',
    match  => '^holberton\s+hard\s+nofile',
    ensure => present,
  }

  # Ensure PAM system applies limits
  file_line { 'ensure-pam-limits':
    path   => '/etc/pam.d/common-session',
    line   => 'session required pam_limits.so',
    match  => '^session\s+required\s+pam_limits.so',
    ensure => present,
  }

  # Update system-wide file descriptor limits
  file_line { 'increase-fd-limit-sysctl':
    path   => '/etc/sysctl.conf',
    line   => 'fs.file-max = 2097152',
    match  => '^fs\.file-max',
    ensure => present,
  }

  exec { 'apply-sysctl-settings':
    command => '/sbin/sysctl -p',
    refreshonly => true,
    subscribe => File_line['increase-fd-limit-sysctl'],
  }
}

# Include the class to apply changes
include user_limit_fix
