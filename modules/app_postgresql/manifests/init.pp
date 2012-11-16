class app_postgresql {
  
  class { 'postgresql::server':
     config_hash => {
         'ip_mask_allow_all_users'    => '0.0.0.0/0',
         'listen_addresses'           => '*',
         'manage_redhat_firewall' => true,
         'postgres_password'          => 'postgres',
         'ip_mask_deny_postgres_user' => '192.169.9.999'
     }
  }
  postgresql::database_user {
    'apies':
      password_hash => '$1$rFs0IBL/$uacksiHX7loGJx4Day0mq.'
  }
  postgresql::database { 
    'mongodqb':
      require   => Class['postgresql::server'];
    'mongodqb-test':
      require   => Class['postgresql::server'];
  }
  
  
}