#Service class
class tomcat::service (

  $service_name   = $tomcat::params::service_name,
  $service_ensure   = $tomcat::params::service_ensure,
  $service_status     =$tomcat::params::service_status,

) inherits tomcat::params {



  service { $service_name:
    ensure    => $service_ensure,
    enable    => $service_status,
    name      => $service_name,
    hasstatus => true,
    require   => Class['tomcat::install'],
  }




}