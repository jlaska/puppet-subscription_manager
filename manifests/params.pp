# subscription_manager Params
class subscription_manager::params {
  $version = 'installed'
  $install_firstboot = false
  $install_gui = false

  $hostname = 'subscription.rhn.redhat.com'
  $port = 443
  
  $baseurl = 'https://cdn.redhat.com'
  $manage_repos = 1
}
