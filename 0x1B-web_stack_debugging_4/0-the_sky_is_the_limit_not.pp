# Fix Nginx to handle more concurrent connections by increasing the open file limit
exec { 'fix--for-nginx':
  command => "/bin/sed -i '/^\\[Service\\]$/a LimitNOFILE=65536' /etc/systemd/system/nginx.service && /bin/systemctl daemon-reload && /bin/systemctl restart nginx",
  onlyif  => "/bin/grep -q '^\\[Service\\]$' /etc/systemd/system/nginx.service && ! /bin/grep -q 'LimitNOFILE=65536' /etc/systemd/system/nginx.service",
}
