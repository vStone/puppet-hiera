# = Class: hiera::params
#
# Configure settings for hiera
#
# == Parameters:
#
# See the main hiera class for all parameters that can be used.
#
# == Sample Usage:
#
#   class {'hiera::params':
#     param => 'value'
#   }
#
# == Todo:
#
# * Add parameters to docs.
#
class hiera::params (
  $package             = undef,
  $hiera_yaml_content  = undef,
  $hiera_yaml_template = 'hiera/hiera.yaml.erb',
  $hiera_yaml_source   = undef,
  $backends            = ['yaml'],
  $logger              = 'console',
  $hierarchy           = ['%{environment}', '%{domain}', '%{hostname}', 'common' ],
  $datadir             = '/etc/puppet/hieradata',
  $datasource          = 'data',
  $manage_config       = true
){
  ## Copy paste snippets:
  # template("${module_name}/template.erb")
  # source => "puppet:///modules/${module_name}/file"

  $packages = $package ? {
    undef   => $::operatingsystem ? {
      default => ['hiera']
    },
    default => $package,
  }

}
