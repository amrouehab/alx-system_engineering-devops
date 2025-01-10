# This Puppet manifest creates a file at /tmp/school with specific permissions, ownership, and content
file { '/tmp/school':
  ensure  => file,
  content => "I love Puppet\n",
  mode    => '0744',
  owner   => 'www-data',
  group   => 'www-data',
}

