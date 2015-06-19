Puppet::Type.type(:rhsm_pool).provide(:subscription_manager) do
  @doc = <<-EOS
    This provider registers applies a specific subscription to the system.
  EOS

  confine :osfamily => :redhat
  confine :feature => :json

  commands :subscription_manager => "subscription-manager"

  def create
    subscription_manager('attach','--pool',@resource[:id])
  end

  def destroy
    #subscription_manager('repos','--disable',@resource[:name])
  end

  def self.consumed_pools
    debug(subscription_manager('list','--pool','--consumed').split("\n"))
    subscription_manager('list','--pool','--consumed').split("\n")
  end

  def self.instances
    consumed_pools.collect do |pool|
      new(:name => pool, :ensure => :present )
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
