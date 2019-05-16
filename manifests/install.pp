class tomcat::install (

#This values are taken from params.pp
  $tomcat_path   = $tomcat::params::tomcat_path,
  $tomcat_target   = $tomcat::params::tomcat_target,
  $user    =   $tomcat::params::user,
  $group    = $tomcat::params::group,


)inherits tomcat::params
  {


file {"$tomcat_path":
      ensure => 'directory',
      owner             =>  $user,
      group             =>  $group,
    }

file {"$tomcat_path/temp":
      ensure => 'directory',
      owner             =>  $user,
      group             =>  $group,
    }




file { "$tomcat_path/apache-tomcat-8.5.31.tar.gz":
      ensure              => file,
      owner             =>  $user,
      group             =>  $group,
      source              => "puppet:///applications/apache-tomcat-8.5.31.tar.gz",
      require        => File["$tomcat_path"],
    }


    # preferred symlink syntax
    file { "$tomcat_path/current":
      owner    => $user,
      group   => $group,
      ensure => 'link',
      target => "$tomcat_path/apache-tomcat-8.5.31",


    }



    # preferred symlink syntax
    file { "$tomcat_target/webapps":
      owner    => $user,
      group    => $group,
      ensure   => 'directory',
      mode     => '0755',


    }

    exec { "install_tomcat":
      path    => '/usr/bin/:/bin/',
      command => "tar xzf $tomcat_path/apache-tomcat-8.5.31.tar.gz -C $tomcat_path",
      unless  => "test -f $tomcat_path/apache-tomcat-8.5.31/bin/startup.sh",
      require => File["$tomcat_path/apache-tomcat-8.5.31.tar.gz"],

    }

    exec { "make_executable":
      path    => '/usr/bin/:/bin/',
      command => "chown -R java: $tomcat_path;chmod -R +x $tomcat_path/current/bin/*.sh",
      unless  => "stat $tomcat_path/current/bin/startup.sh | grep -i 0755",
      require => File["$tomcat_path/apache-tomcat-8.5.31.tar.gz"],

    }

    exec { "remove_tomcat_archive":
      path    => '/usr/bin/:/bin/',
      command => "rm -fr $tomcat_path/apache-tomcat-8.5.31.tar.gz",
      onlyif  => "test -f $tomcat_path/apache-tomcat-8.5.31.tar.gz",
      require => Exec["install_tomcat"],

    }

    tidy { "delete-webapps-folders":
      path    => "$tomcat_path/current/webapps",
      recurse => false,
      matches => [ 'docs', 'examples', 'host-manager', 'manager', 'ROOT' ],
      rmdirs  => false,
    }


  }

