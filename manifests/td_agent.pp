class fluentd::td_agent (

  $elasticsearch_host = $fluentd::params::elasticsearch_host,
  $elasticsearch_port = $fluentd::params::elasticsearch_port,
  $remote_port        = $fluentd::params::remote_port,
  $main_config        = $fluentd::params::main_config,
  $protocol_type      = $fluentd::params::protocol_type

) inherits fluentd::params {

  anchor {'fluentd::td_agent::begin':
    before => Class['fluentd::td_agent::install']
  }
  class {'fluentd::td_agent::install':
    require => Anchor['fluentd::td_agent::begin']
  }
  class {'fluentd::td_agent::config':
    require => Class['fluentd::td_agent::install']
  }
  class {'fluentd::td_agent::service':
    subscribe => Class['fluentd::td_agent::config']
  }
  anchor {'fluentd::td_agent::end':
    require => Class['fluentd::td_agent::service']
  }
}
