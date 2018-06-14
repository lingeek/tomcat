class tomcat::config (


  $tomcat_path   = $tomcat::params::tomcat_path,
  $tomcat_target   = $tomcat::params::tomcat_target,
  $service_unit     =$tomcat::params::service_unit,



)inherits tomcat::params
  {

#Building systemctl UNIT
    file {"$service_unit":
      ensure => $file_present,
      mode                =>'0644',
      content => template('tomcat/tomcat_service.erb'),
      notify    => [
        Exec["systemd_reload"],
        Class['tomcat::service']
        ],
    }


    exec { "systemd_reload":
      path    => '/usr/bin/:/bin/',
      command => "systemctl daemon-reload",
      refreshonly => true,
      #require => File["$tomcat_path/apache-tomcat-8.5.31.tar.gz"],
    }

#service { "tomcat":
 # ensure   => running,
 # require  => Exec["systemd_reload"]

#}

  }

