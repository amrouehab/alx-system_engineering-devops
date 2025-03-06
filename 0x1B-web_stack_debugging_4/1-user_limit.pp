# Reconfigure the OS for 'holberton' to login and open files without errors

class user_limit_fix {
  # Set hard file limit for holberton user
  file_line { 'increase-holberton-hard-limit':
    path  => '/etc/security/limits.conf',
    line  => 'holberton hard nofile 50000',
    match => '^holberton hard nofile',
  }

  # Set soft file limit for holberton user
  file_line { 'increase-holberton-soft-limit':
    path  => '/etc/security/limits.conf',
    line  => 'holberton soft nofile 50000',
    match => '^holberton soft nofile',
  }

  # Ensure PAM applies the new limits
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

