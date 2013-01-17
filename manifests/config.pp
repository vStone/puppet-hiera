# = Class: hiera::config
#
# Setup required files and folders.
#
# == Actions:
#
# Creates the directory within the puppet folder for hieradata.
# Create the main hiera.yaml file.
#
# == Requires:
#
# Puppet must be installed.
#
class hiera::config (
  $manage_config       = $::hiera::manage_config,
  $hiera_yaml_content  = $::hiera::hiera_yaml_content,
  $hiera_yaml_template = $::hiera::hiera_yaml_template,
  $hiera_yaml_source   = $::hiera::hiera_yaml_source
) inherits hiera {

  file {'/etc/puppet/hieradata':
    ensure => 'directory',
  }

  if $manage_config == true {

    if $hiera_yaml_content != undef {
      ## We have content. Use it.
      $hierayaml_content = $hiera_yaml_content
    }
    elsif $hiera_yaml_template != undef {
      ## Template defined. Use it.
      $hierayaml_content = template($hiera_yaml_template)
    }
    elsif $hiera_yaml_source != undef {
      ## Source defined. Use it.
      $hierayaml_source = $hiera_yaml_source
      $hierayaml_content = false
    }
    else {
      ## There is nothing defined.. content is empty.
      $hierayaml_content = ''
    }

    file {'/etc/puppet/hiera.yaml':
      ensure  => 'present',
    }

    if $hierayaml_content == false {
      ## hierayaml_content is false if a sourcefile is defined.
      File['/etc/puppet/hiera.yaml'] {
        source => $hierayaml_source,
      }
    }
    elsif $hierayaml_content != '' {
      ## Use the content. Either defined or from the template.
      File['/etc/puppet/hiera.yaml'] {
        content => $hierayaml_content,
      }
    }
  }

}

