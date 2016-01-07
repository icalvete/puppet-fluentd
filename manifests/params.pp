class fluentd::params {

  $package_td_agent   = 'td-agent'

  $plugins            = ['fluent-plugin-geoip ', 'fluent-plugin-elasticsearch', 'fluent-plugin-parser', 'fluent-plugin-record-reformer']

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

  case $::lsbdistcodename {
    /^precise/: {
      $treasure_data_repo = 'deb http://packages.treasure-data.com/precise/ precise contrib'
      $fluent_gem         = '/usr/lib/fluent/ruby/bin/fluent-gem'
    }
    /^trusty/: {
      $treasure_data_repo = 'deb [arch=amd64] http://packages.treasuredata.com/2/ubuntu/trusty/ trusty contrib'
      $fluent_gem         = '/opt/td-agent/embedded/bin/fluent-gem'
    }
    default: {
      fail ("${::operatingsystem} not supported.")
    }
  }

  $main_config = "${module_name}/sp.conf.erb"
}
