class fluentd::td_agent::config {

  $config_file = $fluentd::td_agent::main_config

  file{ "${fluentd::params::config_dir}/conf.d/":
    ensure => directory,
    mode   => '0755',
    before => File['fluentd_config']
  }

  file{'fluentd_config':
    ensure  => present,
    content => template($config_file),
    path    => "${fluentd::params::config_dir}/conf.d/sp.conf",
    mode    => '0644',
  }

  exec{ 'active_td_agent_includes':
    command  => "/bin/echo 'include ${fluentd::params::config_dir}/conf.d/*.conf' >> ${fluentd::params::config_file}",
    unless   => "/bin/grep include ${fluentd::params::config_file}",
    provider => 'shell'
  }
}

