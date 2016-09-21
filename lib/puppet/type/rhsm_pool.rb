require 'puppet/property/boolean'
require 'puppet/type'

Puppet::Type.newtype(:rhsm_pool) do
  @doc = ""

  ensurable

  newparam(:id, :namevar => true) do
    desc "Pool id"
  end

  newproperty(:serial) do
    desc "Pool serial"
  end


end
