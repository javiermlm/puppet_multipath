class multipath::service {
  service { multipathd:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
  }
}
