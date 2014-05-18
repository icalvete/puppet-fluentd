class fluentd::install {

  package{ $fluentd::params::package:
    ensure => present,
  }
}

