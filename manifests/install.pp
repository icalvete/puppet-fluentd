class fluentd::install {

  package{ $fluentd::params::package:
    ensure => present,
    before => Fluentd::Plugin[$fluentd::params::plugins]
  }

  fluentd::plugin {$fluentd::params::plugins:}
}

