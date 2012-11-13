class mongodqb {
  file {
    ["/var/mongodqb","/var/mongodqb/shared/", "/var/mongodqb/shared/config"]:
        ensure => directory,
        owner => vagrant,
        group => vagrant,
        mode =>  775
  }
  file {
    "/var/mongodqb/shared/config/database.yml":
      ensure => present,
      owner => vagrant,
      group => vagrant,
      mode => 600,
      source => "puppet:///modules/mongodqb/database.yml"
  }
  package {
    "bundler":
      provider => gem
  }
}