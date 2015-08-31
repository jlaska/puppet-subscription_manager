# subscription_manager Params
class subscription_manager::params {
  $version = 'installed'
  $install_firstboot = false
  $install_gui = false

  $hostname = 'subscription.rhn.redhat.com'
  $port = 443
  $insecure = 0
  $prefix = '/subscription'

  $baseurl = 'https://cdn.redhat.com'
  $ca_cert_dir = '/etc/rhsm/ca/'
  $repo_ca_cert = '%(ca_cert_dir)sredhat-uep.pem'
  $manage_repos = 1
  $full_refresh_on_yum = 0
  $report_package_profile = 1
}
