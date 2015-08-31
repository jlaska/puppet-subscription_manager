#
# == Class: subscription_manager
#
# Install and configure subscription_manager
#
# === Parameters:
#
# $version::                       subscription-manager package version, it's passed to ensure parameter of package resource
#                                  can be set to specific version number, 'latest', 'present' etc.
#
#
# $install_firstboot::             boolean; controls whether firstboot is installed or not. Defaults to false
#                                  type:boolean
#
# $install_gui::                   boolean; controls whether gui is installed or not. Defaults to false
#                                  type:boolean
#
# $hostname::                      Server hostname
#
# $port::                          Server port
#
# $baseurl::                       Content base URL
#
# $manage_repos::                  Manage generation of yum repositories for subscribed content
#
# $insecure::                      Set to 1 to disable certificate validation
#
# $full_refresh_on_yum::           Refresh repo files with server overrides on every yum command
#
# $report_package_profile::        If set to zero, the client will not report the package profile to
#                                  the subscription management service.
#
# === Examples
#
#  class { subscription_manager:
#
#  }
#
# === Authors
#
# Gaël Chamoulaud <gchamoul@redhat.com>
#
# === Copyright
#
# Copyright 2013 Gaël Chamoulaud <gchamoul@redhat.com>
#
class subscription_manager (
  $version                = $subscription_manager::params::version,
  $install_firstboot      = $subscription_manager::params::install_firstboot,
  $install_gui            = $subscription_manager::params::install_gui,
  $hostname               = $subscription_manager::params::hostname,
  $port                   = $subscription_manager::params::port,
  $insecure               = $subscription_manager::params::insecure,
  $baseurl                = $subscription_manager::params::baseurl,
  $manage_repos           = $subscription_manager::params::manage_repos,
  $prefix                 = $subscription_manager::params::prefix,
  $ca_cert_dir            = $subscription_manager::params::ca_cert_dir,
  $repo_ca_cert           = $subscription_manager::params::repo_ca_cert,
  $full_refresh_on_yum    = $subscription_manager::params::full_refresh_on_yum,
  $report_package_profile = $subscription_manager::params::report_package_profile,
) inherits subscription_manager::params {
  class { '::subscription_manager::install': } ->
  class { '::subscription_manager::config': }
}
