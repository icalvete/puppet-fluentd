class fluentd::install {

  realize Package['make']

  package{ $fluentd::params::package:
    ensure  => present,
    require => Package['make']
  }
}

