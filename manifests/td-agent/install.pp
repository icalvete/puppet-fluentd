class fluentd::td-agent::install {

  package{ $fluentd::params::package_td_agent:
    ensure  => present
  }
}

