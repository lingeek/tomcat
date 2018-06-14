# Class: tomcat
# ===========================
#

# Copyright
# ---------
#
# Copyright 2018 Alexandru Raul, unless otherwise noted.
#
class tomcat {

  include tomcat::install
  include tomcat::config
  include tomcat::service
  include tomcat::setup

}
