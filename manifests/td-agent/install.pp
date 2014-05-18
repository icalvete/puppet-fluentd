class fluentd::td-agent::install {

  package{ $fluentd::params::package_td_agent:
    ensure => present,
  }

  fluentd::plugin {$fluentd::params::plugins:
    require => Package[$fluentd::params::package_td_agent]
  }
}

