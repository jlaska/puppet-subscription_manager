# Installs the package for a given subscription_manager plugin
define subscription_manager::plugin(
  $version     = $subscription_manager::version,
  $package     = "subscription_manager-plugin-${title}",
) {
  package { $package:
    ensure => $version,
  }
}
