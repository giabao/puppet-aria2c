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
  $repo = 'http://pkgs.repoforge.org' 
  $ext = 'el6.rf.x86_64.rpm'
  package{'nettle':
    ensure    => installed,
    provider  => rpm,
    source    => "$repo/nettle/nettle-$nettle.$ext",
  }->
  package{'aria2':
    ensure    => installed,
    provider  => rpm,
    source    => "$repo/aria2/aria2-$version.$ext",
  }
}
