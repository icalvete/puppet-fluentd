class fluentd::td-agent () inherits fluentd::params {

  anchor {'fluentd::td-agent::begin':
    before => Class['fluentd::td-agent::preinstall']
  }
  class {'fluentd::td-agent::preinstall':
    require => Anchor['fluentd::td-agent::begin']
  }
  class {'fluentd::td-agent::install':
    require => Class['fluentd::td-agent::preinstall']
  }
  class {'fluentd::td-agent::config':
    require => Class['fluentd::td-agent::install']
  }
  class {'fluentd::td-agent::service':
    subscribe => Class['fluentd::td-agent::config']
  }
  anchor {'fluentd::td-agent::end':
    require => Class['fluentd::td-agent::service']
  }
}
