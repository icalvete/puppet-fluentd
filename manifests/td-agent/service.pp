class fluentd::td-agent::service {

  service{ 'td-agent':
    enable     => true,
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
  }
}
