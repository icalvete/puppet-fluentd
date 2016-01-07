class fluentd::td_agent::service {

  service{ 'td-agent':
    enable     => true,
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
  }
}
