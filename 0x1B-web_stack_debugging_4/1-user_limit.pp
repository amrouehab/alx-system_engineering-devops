# This Puppet manifest increases open file limits for the holberton user.

class user_limit_fix {
  file_line { 'increase-holberton-nofile-soft':
    path  => '/etc/security/limits.conf',
    line  => 'holberton soft nofile 65535',
    match => '^holberton soft nofile',
  }

  file_line { 'increase-holberton-nofile-hard':
    path  => '/etc/security/limits.conf',
    line  => 'holberton hard nofile 65535',
    match => '^holberton hard nofile',
  }

  file_line { 'enable-pam-limits':
    path  => '/etc/pam.d/common-session',
    line  => 'session required pam_limits.so',
    match => '^session required pam_limits.so',
  }

  file_line { 'enable-pam-limits-noninteractive':
    path  => '/etc/pam.d/common-session-noninteractive',
    line  => 'session required pam_limits.so',
    match => '^session required pam_limits.so',
  }
}

include user_limit_fix

