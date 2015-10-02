Puppet::Type.type(:rhsm_pool).provide(:subscription_manager) do
  @doc = <<-EOS
    This provider registers applies a specific subscription to the system.
  EOS

  confine :osfamily => :redhat
  confine :feature => :json

  commands :subscription_manager => "subscription-manager"

  mk_resource_methods

  def create
    subscription_manager('attach','--pool',@resource[:id])
  end

  def destroy
    subscription_manager('remove','--serial',@resource[:serial])
  end

  def serial=(serial)
    fail_read_only
  end

  def self.consumed_pools
    subscription_manager('list','--consumed').scan(/Serial\: +([0-9]+)\nPool ID\: +([A-Za-z0-9]+)/m)
  end

  def self.instances
    consumed_pools.collect do |serial,pool|
      new(:name => pool, :ensure => :present, :serial => serial)
    end
  end

  def self.prefetch(resources)
    instances.each do |prov|
      if resource = resources[prov.name]
        resource.provider = prov
      end
    end
  end

  def exists?
    @property_hash[:ensure] == :present
  end

end
