Puppet::Type.type(:rhsm_repo).provide(:subscription_manager) do
  @doc = <<-EOS
    This provider registers a software repository via RedHat subscription manager.
  EOS

  confine :osfamily => :redhat

  commands :subscription_manager => "subscription-manager"

  def create
    subscription_manager('repos','--enable',@resource[:name])
  end

  def destroy
    subscription_manager('repos','--disable',@resource[:name])
  end

  def self.enabled_repos
    subscription_manager('repos').scan(/Repo ID: +([^\n\t ]+)\n(?:[^\n]+\n)+Enabled: +1\n/m).flatten
  end

  def self.instances
    enabled_repos.collect do |repo|
      new(:name => repo, :ensure => :present)
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
