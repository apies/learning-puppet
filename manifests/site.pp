
Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin/:sbin:/bin"
  
}

#todo add a remove the sites-enabled/default
include nginx
include app_postgresql
include mongodqb

user {
  "apies":
  name => 'apies',
  password => '$1$rFs0IBL/$uacksiHX7loGJx4Day0mq.',
  ensure  => "present",
  managehome => true,
  roles => admin
}







