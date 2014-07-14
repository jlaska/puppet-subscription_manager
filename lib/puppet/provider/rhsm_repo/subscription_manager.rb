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

  def self.instances
    repo_file = '/var/lib/rhsm/cache/written_overrides.json'
    repo_instances = Array.new
    if File.exists?(repo_file)
      repos = JSON.parse(File.open(repo_file).read)
      repos.each do |key, values|
	debug("Checking enabled for #{key}")
       if repos[key]['enabled'] == '1'
	  debug("#{key} enabled")
	  repo_instances.push(new(:name => key, :ensure => :present))
	end
     end
      return repo_instances
    end
  end

  def self.prefetch(resources)
    repos = instances
    resources.keys.each do |name|
      if provider = repos.find{ |repo| repo.name == name }
        resources[name].provider = provider 
      end
    end
  end

  def exists?
    debug("Verifying whether repo is enabled")

    @property_hash[:ensure] == :present
  end

end
