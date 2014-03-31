define fluentd::plugin (

  $ensure = 'present'

) {

  case $ensure {
    'present': {
      exec{ "install_${name}":
        command => "${fluentd::params::fluent_gem} install ${name}",
        unless  => "${fluentd::params::fluent_gem} list | /bin/grep ${name}",
      }
    }
    'absent': {
      exec{ "uninstall_${name}":
        command => "${fluentd::params::fluent_gem} uninstall ${name}",
        onlyif  => "${fluentd::params::fluent_gem} list | /bin/grep ${name}",
      }
    }
    default:{}
  }
}
