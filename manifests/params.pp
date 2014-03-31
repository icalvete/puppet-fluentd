class fluentd::params {

  $package_td_agent   = 'td-agent'

  $fluent_gem         = '/usr/lib/fluent/ruby/bin/fluent-gem'
  $plugins            = ['fluent-plugin-geoip ', 'fluent-plugin-elasticsearch']

  $remote_port        = hiera('syslog_remote_port')
  $elasticsearch_host = hiera('elasticsearch_vip')

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {

      $config_dir  = '/etc/td-agent'
      $config_file = "${config_dir}/td-agent.conf"
      $package     = [
        'libcurl4-nss-dev',
        'libgeoip-dev'
      ]
    }
    default: {
      fail("Operating system ${::operatingsystem} is not supported")
    }
  }
}
