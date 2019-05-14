class tomcat::setup (


  $file_present =  $tomcat::params::file_present,
  $tomcat_server_file_path = $tomcat::params::tomcat_server_file_path,



)inherits tomcat::params
  {

    file { "$tomcat_server_file_path":
      ensure  => $file_present,
      content => template('tomcat/server_config.erb'),
      require => Class['tomcat::install'],
      notify => Class['tomcat::service'],
    }


  }

