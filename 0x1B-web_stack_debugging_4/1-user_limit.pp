# Increase the open file limit for the holberton user to allow login and file access
exec { 'change-os-configuration-for-holberton-user':
  command => "/bin/echo 'holberton soft nofile 65536' >> /etc/security/limits.conf && /bin/echo 'holberton hard nofile 65536' >> /etc/security/limits.conf",
  unless  => "/bin/grep -q 'holberton.*nofile' /etc/security/limits.conf",
}
