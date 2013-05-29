Puppet::Type.type(:rhsm_register).provide(:subscription_manager) do
  @doc = <<-EOS
    This provider registers a machine with cert-based Red Hat Subscription
    Manager.  If a machine is already registered it does nothing unless the
    force parameter is set to true.
  EOS

  confine :osfamily => :redhat

  commands :subscription_manager => "subscription-manager"

  def build_config_parameters
    params = []
    params << "config"
    params << "--server.hostname" << @resource[:server_hostname] if ! @resource[:server_hostname].nil?
    params << "--server.insecure" if @resource[:server_insecure]
    params << "--rhsm.baseurl" <<  @resource[:rhsm_baseurl] if ! @resource[:rhsm_baseurl].nil?

    return params
  end

  def build_register_parameters
    params = []
    if @resource[:username].nil? and @resource[:activationkeys].nil?
        self.fail("Either an activation key or username/password is required to register")
    end

    params << "register"
    params << "--username" << @resource[:username] if ! @resource[:username].nil?
    params << "--password" << @resource[:password] if ! @resource[:password].nil?
    params << "--activationkey" <<  @resource[:activationkeys] if ! @resource[:activationkeys].nil?
    params << "--force" if @resource[:force]
    params << "--autosubscribe" if @resource[:autosubscribe]

    return params
  end

  def config
    Puppet.debug("This server will be configered for rhsm")
    cmd = build_config_parameters
    subscription_manager(*cmd)
  end

  def register
    Puppet.debug("This server will be registered")
    cmd = build_register_parameters
    subscription_manager(*cmd)
  end

  def unregister
    Puppet.debug("This server will be locally unregistered")
    cmd = []
    cmd << "unregister"
    subscription_manager(*cmd)
  end

  def create
    config
    register
    # subscribe
  end

  def destroy
    unregister
  end

  def exists?
    Puppet.debug("Verifying if the server is already registered")
    if File.exists?("/etc/pki/consumer/cert.pem") or File.exists?("/etc/pki/consumer/key.pem")
      if @resource[:force] == true
        unregister
        register
      end
      return true
    else
      return false
    end
  end

end
