# subscription_manager Install Packages
class subscription_manager::install {
  package { ['subscription-manager']:
    ensure => $subscription_manager::version,
  }

  if $subscription_manager::install_firstboot {
    package { 'subscription-manager-firstboot':
      ensure => $subscription_manager::version,
    }
  }

  if $subscription_manager::install_gui {
    package { 'subscription-manager-gui':
      ensure => $subscription_manager::version,
    }
  }
}
