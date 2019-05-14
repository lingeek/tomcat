class tomcat::params (

  $jdk_path   = hiera('common::path::jdk::path'),
  $tomcat_path   = hiera('common::path:tomcat::path'),
  $tomcat_server_file_path  = hiera('common::tomcat::file::path'),
  $tomcat_target   = hiera('node::tomcat::target'),
  $user    = hiera('common::tomcat::user'),
  $group    = hiera('common::tomcat::group'),
  $service_unit    = hiera('common::tomcat::service::unit::path'),
  $file_present = hiera('common::file::ensure'),
  $tomcat_port = hiera('node::tomcat::port'),
  $service_name             = hiera('node::tomcat::service::name'),
  $service_status = hiera('node::tomcat::service::status'),
  $service_ensure = hiera('node::tomcat::service::enable'),



){





}