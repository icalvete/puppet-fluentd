class fluentd::install {

  realize Package['make']
  realize Package['libmaxminddb-dev']

  package{ $fluentd::params::package:
    ensure  => present,
    require => Package['make']
  }
}

