class multipath {
 if $productname != 'VMware Virtual Platform'{
  include multipath::service
  $mfile = template('multipath/multipath.erb')
  file { '/etc/multipath.conf':
    ensure => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => $mfile,
  }
  case $::operatingsystemrelease {
    /^5/: {
        $modfile = '/etc/modprobe.conf'
    }
    /^6/: {
        $modfile = '/etc/modprobe.d/modprobe.conf'
    }
  }
  file { $modfile:
     ensure => present,
     owner => root,
     group => root,
     mode => '0644',
  }
  file_line { '3PAR_opts':
     ensure => present,
     path => $modfile,
     line => 'options lpfc lpfc_devloss_tmo=14 lpfc_lun_queue_depth=16 lpfc_discovery_threads=32',
     match => '^options lpfc',
     require => File[$modfile],
  }
 } else {
        notify {"I'm a vmware guest": }
 }
}
