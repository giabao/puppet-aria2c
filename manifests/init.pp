# Class: aria2c
#
# This module is used to download files from internet using aria2c
#
# Parameters: ?
#
# Actions: ?
#
# Requires: see Modulefile
#
# Sample Usage: ?
#
class aria2c($version='1.16.4-1', $nettle='2.2-1'){
  if ($::operatingsystem != 'CentOS' or $::architecture != 'x86_64') {
    fail('CentOS x86_64 only!')
  }
  $repo = 'http://apt.sw.be/redhat/el6/en/x86_64/rpmforge/RPMS' 
  $ext = 'el6.rf.x86_64.rpm'
  Package{ensure => installed}
  package{'gnutls':}
  ->
  package{'nettle':
    provider  => rpm,
    source    => "$repo/nettle-$nettle.$ext",
  }
  ->
  package{'aria2':
    provider  => rpm,
    source    => "$repo/aria2-$version.$ext",
  }
}
