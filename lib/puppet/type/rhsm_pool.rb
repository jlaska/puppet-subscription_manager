require 'puppet/property/boolean'
require 'puppet/type'

Puppet::Type.newtype(:rhsm_pool) do
  @doc = ""

  ensurable

  newparam(:id, :namevar => true) do
    desc "The rhsm channel to subscribe to."
  end

end
