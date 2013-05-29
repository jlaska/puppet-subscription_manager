require 'puppet/property/boolean'
require 'puppet/type'

Puppet::Type.newtype(:rhsm_register) do
  @doc = ""

  ensurable do

    newvalue(:present) do
      provider.create
    end

    newvalue(:absent) do
      provider.destroy
    end

    def insync?(is)

      @should.each do |should|
        case should
        when :present
          return true if is == :present
        when :absent
          return true if is == :absent
        end
      end
      return false
    end
    defaultto :present
  end

  newparam(:server_hostname, :namevar => true) do
    desc "The rhsm server hostname."
  end

  newparam(:server_insecure, :parent => Puppet::Property::Boolean) do
    desc "Should an insecure https connection be used."
    defaultto false
  end

  newparam(:rhsm_baseurl) do
    desc "Specify a CDN baseurl to use"
  end

  newparam(:username) do
    desc "The username to use when registering the system"
  end

  newparam(:password) do
    desc "The password to use when registering the system"
  end

  newparam(:activationkeys) do
    desc "The activation key to use when registering the system (cannot be used with username and password)"
  end

  newparam(:autosubscribe, :parent => Puppet::Property::Boolean) do
    desc "Automatically attach this system to compatible subscriptions."
    defaultto false
  end

  newparam(:force, :parent => Puppet::Property::Boolean) do
    desc "Should the registration be forced. Use this option with caution,
	  setting it true will cause the subscription-manager command to be run
          every time runs."
    defaultto false
  end

end
