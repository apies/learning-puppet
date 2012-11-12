Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin/:sbin:/bin"
  
   
	
}

include nginx


class { 'postgresql::server':
   config_hash => {
       'ip_mask_allow_all_users'    => '127.0.0.1/0',
       'listen_addresses'           => '*',
       'manage_redhat_firewall' => true,
       'postgres_password'          => 'postgres',
       'ip_mask_deny_postgres_user' => '192.169.9.999'
   }
}

#  postgresql::db { 'mydb':
#    user     => 'my_user',
#    password => 'password',
#    grant    => 'all'
#  }



postgresql::database_user {
  'apies':
    password_hash => '$1$zzVHWC1w$BZz0T4XLK5JRw0QDN97GW1'
}