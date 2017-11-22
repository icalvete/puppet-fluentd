class fluentd::params {

  $package_td_agent   = 'td-agent'

  $plugins            = [
    'fluent-plugin-geoip ',
    'fluent-plugin-elasticsearch',
    'fluent-plugin-parser',
    'fluent-plugin-record-reformer'
  ]

  $remote_port        = hiera('fluentd_remote_port', '5514')

  $elasticsearch_host = hiera('elasticsearch_vip', '127.0.0.1')
  $elasticsearch_port = 9200

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {

      $config_dir  = '/etc/td-agent'
      $config_file = "${config_dir}/td-agent.conf"
      $package     = [
        'libcurl4-nss-dev',
        'libgeoip-dev',
        'libc6-dev'
      ]
    }
    default: {
      fail("Operating system ${::operatingsystem} is not supported")
    }
  }

  case $::lsbdistcodename {
    /^precise/: {
      $treasure_data_location = 'http://packages.treasure-data.com/precise/'
      $fluent_gem             = '/usr/lib/fluent/ruby/bin/fluent-gem'
    }
    /^trusty/: {
      $treasure_data_location = 'http://packages.treasuredata.com/2/ubuntu/trusty/'
      $fluent_gem             = '/opt/td-agent/embedded/bin/fluent-gem'
    }
    /^xenial/: {
      $treasure_data_location = 'http://packages.treasuredata.com/2/ubuntu/xenial/'
      $fluent_gem             = '/opt/td-agent/embedded/bin/fluent-gem'
    }
    default: {
      fail ("${::operatingsystem} not supported.")
    }
  }

  $treasure_data_key_id = 'BEE682289B2217F45AF4CC3F901F9177AB97ACBE'

  $main_config   = "${module_name}/sp.conf.erb"
  $protocol_type = 'udp'
}
