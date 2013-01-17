# == Class: hiera
#
# This module manages hiera
#
# === Parameter:
#
# $package::              Override the packages to install.
#                         Defaults to ['rubygem-hiera','rubygem-hiera-puppet'].
#
# $hiera_yaml_content::   Override the content to be placed in the config file.
#
# $hiera_yaml_template::  Use a custom template to create the config file.
#                         Defaults to 'hiera/hiera.yaml.erb'.
#
# $hiera_yaml_source::    Provide a custom source for the config file.
#
# $backends::             Hiera backends to configure. This is only used when
#                         a template is used for the hiera_yaml file.
#                         Defaults to ['yaml','puppet'].
#
# $logger::               Where to log to. Defaults to 'console'.
#
# $hierarchy::            Hierarchy to use. Use an array with the top most
#                         element first.
#                         Defaults to: [
#                           '%{environment}', '%{domain}',
#                           '%{hostname}', 'common'
#                         ]
#
# $datadir::              Directory where the hiera data is located.
#                         Defaults to '/etc/puppet/hieradata'.
#
# $datasource::           The puppet class in which to look for data.
#                         Defaults to 'data'.
#
# $manage_config::        Completely enable or disable management of the
#                         hiera.yaml configuration file.
#
class hiera (
  $package             = $::hiera::params::packages,
  $hiera_yaml_content  = $::hiera::params::hiera_yaml_content,
  $hiera_yaml_template = $::hiera::params::hiera_yaml_template,
  $hiera_yaml_source   = $::hiera::params::hiera_yaml_source,
  $backends            = $::hiera::params::backends,
  $logger              = $::hiera::params::logger,
  $hierarchy           = $::hiera::params::hierarchy,
  $datadir             = $::hiera::params::datadir,
  $datasource          = $::hiera::params::datasource,
  $manage_config       = $::hiera::params::manage_config
) inherits hiera::params {
  include hiera::packages
  include hiera::config
}
