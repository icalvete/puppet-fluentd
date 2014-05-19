class fluentd::td-agent::config (

  $config_template = "${module_name}/sp.conf.erb"

) {

  file{ "${fluentd::params::config_dir}/conf.d/":
    ensure => directory,
    mode   => '0755',
    before => File['fluentd_custom_config']
  }

  file{'fluentd_custom_config':
    ensure  => present,
    content => template($config_template),
    path    => "${fluentd::params::config_dir}/conf.d/sp.conf",
    mode    => '0644',
  }

  exec{ 'active_td_agent_includes':
    command  => "/bin/echo 'include ${fluentd::params::config_dir}/conf.d/*.conf' >> ${fluentd::params::config_file}",
    unless   => "/bin/grep include ${fluentd::params::config_file}",
    provider => 'shell'
  }
}

