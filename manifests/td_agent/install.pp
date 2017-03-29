class fluentd::td_agent::install {

  apt::source { 'td_agent':
    location => $fluentd::params::treasure_data_location,
    repos    => "${lsbdistcodename} contrib",
    key      => {
      'id'     => $fluentd::params::treasure_data_key_id,
      'server' => 'pgp.mit.edu',
    },
  }

  package{ $fluentd::params::package_td_agent:
    ensure => present,
    require => [
      Apt::Source['td_agent'],
      Class['apt::update']]
  }

  fluentd::plugin {$fluentd::params::plugins:
    require => Package[$fluentd::params::package_td_agent]
  }
}

