# use aria2c to fetch from url $source to file $dest
# @param $cache:
#   = true (default) to cache to /tmp/aria2_cache
#   = false to NOT cache
#   = full path to cache to that path
define aria2c::fetch(
  $source = $name,
  $dest,
  $timeout = "0",
  $headers = [],
  $cache = true,
){
  include stdlib
  if $cache != false {
    if $cache == true {
      $c = "/tmp/aria2_cache$dest"
    } else {
      $c = $cache
    }
    exec {"/bin/cp -T $c $dest":
      creates => $dest,
      onlyif => "/usr/bin/test -f $c",
      before => Exec["fetch $name"],
    }

    #cache's parent directory
    $d = regsubst($c, '^(.*)/[^/]+$', '\1')
    exec {"/bin/mkdir -p $d":
      creates => $d,
    }->
    exec {"/bin/cp -T $dest $c":
      creates => $c,
      require => Exec["fetch $name"],
    }
  }
  $joined = join(prefix($headers, '--header="'), '" ')
  if $joined == ""{ 
    $headersOpt = ""
  }else{
    $headersOpt = "$joined\""
  }
  
  exec {"fetch $name":
    command => "/usr/bin/aria2c -x12 -s12 -k2M --check-certificate=false -o $dest $headersOpt $source",
    timeout => $timeout,
    cwd => '/',
    creates => $dest,
    require => [Class[aria2c]],
  }
}
