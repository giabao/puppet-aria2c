define aria2c::fetch($source = $name, $dest, $timeout="0", $headers=[]){
  include stdlib
  $joined = join(prefix($headers, '--header="'), '" ')
  if $joined == ""{ 
    $headersOpt = ""
  }else{
    $headersOpt = "$joined\""
  }
  
  exec {"/usr/bin/aria2c -x8 -s8 -k2M --check-certificate=false -o $dest $headersOpt $source":
    timeout => $timeout,
    cwd => '/',
    creates => $dest,
    require => [Class[aria2c]],
  }
}
