class fluentd () inherits fluentd::params {

  anchor {'fluentd::begin':
    before => Class['fluentd::install']
  }
  class {'fluentd::install':
    require => Anchor['fluentd::begin']
  }
  class {'fluentd::config':
    require => Class['fluentd::install']
  }
  anchor {'fluentd::end':
    require => Class['fluentd::config']
  }
}
