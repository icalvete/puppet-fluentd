class fluentd::td_agent::preinstall {

  file{ 'fluentd_GPG-KEY-td-agent':
    ensure => present,
    source => "puppet:///modules/${module_name}/GPG-KEY-td-agent",
    path   => '/tmp/GPG-KEY-td-agent',
    mode   => '0664',
  }

  exec{ 'add_fluentd_gpg_key':
    command => '/usr/bin/apt-key add /tmp/GPG-KEY-td-agent',
    require => File['fluentd_GPG-KEY-td-agent'],
    unless  => '/usr/bin/apt-key |/bin/grep \'Treasure Data\''
  }

  file{ 'add_treasure-data_repo':
    ensure  => present,
    path    => '/etc/apt/sources.list.d/treasure-data.list',
    content => "${fluentd::params::treasure_data_repo}\n",
    mode    => '0664',
    require => Exec['add_fluentd_gpg_key'],
    notify  => Exec['update_treasure-data_repo'],
  }

  exec {'update_treasure-data_repo':
    command     => '/usr/bin/apt-get update',
    require     => File['add_treasure-data_repo'],
    refreshonly => true,
  }
}

