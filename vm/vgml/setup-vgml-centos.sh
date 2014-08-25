#!/bin/bash
# Configure CentOS 6 virtual machine as a VGML image

set +e

rpm -Uvh http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-7.noarch.rpm
yum install -y puppet
puppet module install stahnma/epel
puppet apply vgml.pp
