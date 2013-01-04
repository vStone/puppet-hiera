module Puppet::Parser::Functions

  newfunction(:hiera_resources, :type => :statement, :doc => <<-EODOC
Creates resources from a hiera tree.

This function will create all resources defined in a hiera tree.
Current ENC implementations can only use classes to be included (with parameters).
This function allows you to also use defines straight from hiera.


EODOC
  ) do |args|
    raise Puppet::Error, "hiera_resources requires 1 argument; got #{args.length}" if args.length != 1

    Puppet::Parser::Functions.autoloader.load(:hiera_hash) unless \
      Puppet::Parser::Functions.autoloader.loaded?(:hiera_hash)
    Puppet::Parser::Function.autoloader.load(:include) unless \
      Puppet::Parser::Functions.autoloader.loaded?(:include)

    apps = function_hiera_hash(args[0], {})
    apps.each do |res_type, resources|
      if Puppet::Type.type(res_type) or find_definition(res_type)
        resources.map do |key, value|
          if value == nil
            resources[key] = {}
          end
        end
        function_create_resources([res_type, resources])
      elsif find_hostclass(res_type)
        if resources == nil
          function_include([res_type])
        else
          function_create_resources(['class', { res_type => resources}])
        end
      end
    end
  end
end
