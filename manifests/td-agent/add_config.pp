define fluentd::td-agent::add_config {

  if ! $path {
    fail('fluentd::td-agent::add_config need path parameter.')
  }

  if $name =~ /(.*)\/(.*)/ {
      $path      = $1
      $file      = $2
  }

  file{"fluentd_custom_config_${file}":
    ensure  => present,
    source  => "puppet:///modules/${path}/${file}",
    path    => "${fluentd::params::config_dir}/conf.d/${file}.conf",
    mode    => '0644',
    require => Class['fluentd::td-agent::config'],
    notify  => Class['fluentd::td-agent::service']
  }
}
