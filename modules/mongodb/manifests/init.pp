class mongodb {

    #$add-key = "/usr/bin/apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10"
    #$mongodb-repo = "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen"

    Exec { require => Package["python-software-properties"] }

    exec { "add-10gen-key":
        command => "/usr/bin/apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10",
        onlyif => "/usr/bin/apt-key list | /usr/bin/awk '$0 ~ /10gen/ { exit 1 }' /etc/apt/sources.list"
    }

    exec { "10gen-repo" :
        command => "/usr/bin/add-apt-repository deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen",
        require => Exec["add-10gen-key"],
        onlyif => "/usr/bin/awk '$0 ~ /10gen/ { exit 1 }' /etc/apt/sources.list"
    }

    #$required-execs = [ "10gen-repo" ]

    exec { "mongodb-apt-ready" :
        command => "/usr/bin/apt-get update",
        #require => Exec[$required-execs],
        onlyif => "/usr/bin/test ! -x /usr/bin/mongo"
    }

    package { [ "mongodb-10gen" ] :
        ensure => "installed",
        require => Exec["mongodb-apt-ready"]
    }

    service { "mongodb":
        ensure => "running",
        enable => "true",
        require => Package["mongodb-10gen"]
    }

    file {
        "/etc/mongodb.conf":
          source => "puppet:///modules/mongodb/mongodb.conf",
          mode => 644,
          owner => root,
          group => root,
          notify => Service["mongodb"],
          require => Package["mongodb-10gen"]
    }

    file {
        "/etc/apt/sources.list.d/10gen.list":
          source => "puppet:///modules/mongodb/10gen.list",
          mode => 644,
          owner => root,
          group => root,
          notify => Service["mongodb"],
          require => Package["mongodb-10gen"]
    }

}