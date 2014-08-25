include epel

package { ["python", "python-devel"]: 
    ensure => installed,
}

package { ["python-pip"]: 
    ensure => installed,
    require => [Class["epel"], Package["python"], Package["python-devel"]],
}

package { ["curl", "wget", "subversion", "mercurial", "ftp", "bzip2", "bzip2-devel",
            "elfutils", "ntp", "ntpdate", "gcc", "gcc-c++", "gcc-gfortran",
            "compat-gcc-34-g77", "make", "openssh", "openssh-clients",
            "swig", "libpng-devel", "freetype-devel",
            "atlas", "atlas-devel", "libffi-devel", "mlocate"]:
    ensure => installed,
    require => Class["epel"],
}

package { ["ca-certificates" ]:
    ensure => latest,
    require => Class["epel"],
}

package {  ["python-swiftclient", "python-keystoneclient"]:
    ensure => installed,
    provider => "pip",
    require => Package["python-pip"],
}

package { ["numpy", "unittest2", "setuptools", "pip"]:
    ensure => latest,
    provider => "pip",
    require => Package["python-pip"],
}

package { ["scipy"]:
    ensure => latest,
    provider => "pip",
    require => [Package["python-pip"], Package["numpy"]],
}

package { ["matplotlib"]:
    ensure => latest,
    provider => "pip",
    require => [Package["python-pip"], Package["numpy"]],
}

$curl_cmd = "/usr/bin/curl"
$bootstrapLocation = "/etc/rc.d/rc.local"
exec { "get-bootstrap":
    before => File[$bootstrapLocation],
    command => "$curl_cmd -L https://svn.auscope.org/subversion/AuScopePortal/VEGL-Portal/trunk/vm/ec2-run-user-data.sh > $bootstrapLocation",
}
file { $bootstrapLocation: 
    ensure => present,
    mode => "a=rwx",
}
