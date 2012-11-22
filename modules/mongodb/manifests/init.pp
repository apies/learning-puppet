class mongodb {

    #1
    package { "python-software-properties":
        ensure => installed,
        #require => Exec["10gen-repo"]
    }

    #2
    exec { "add-10gen-key":
        command => "/usr/bin/apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10",
        require => Package["python-software-properties"]
    }

    #3
    file {
        "/etc/apt/sources.list.d/10gen.list":
          source => "puppet:///modules/mongodb/10gen.list",
          mode => 644,
          owner => root,
          group => root,
          require => Exec["add-10gen-key"]
    }

    #5
    exec { "mongodb-apt-ready" :
        command => "/usr/bin/apt-get update",
        #require => Exec[$required-execs],
        onlyif => "/usr/bin/test ! -x /usr/bin/mongo",
        require => File["/etc/apt/sources.list.d/10gen.list"]
    }

    #6
    package { "mongodb-10gen":
        ensure => "installed",
        require => Exec["mongodb-apt-ready"]
    }

    #7
    service { "mongodb":
        ensure => "running",
        enable => "true",
        require => Package["mongodb-10gen"]
    }

    #will need later
    #file {
    #    "/etc/mongodb.conf":
    #      source => "puppet:///modules/mongodb/mongodb.conf",
    #      mode => 644,
    #      owner => root,
    #      group => root,
    #      notify => Service["mongodb"],
    #      require => Package["mongodb-10gen"]
    #}



}