# Install epel-release (Extra Packages for Enterprise Linux) repo
include:
  - epel

# Install dkms (Dynamic Kernel Module Support) for VirtualBox integration
dkms:
  pkg.installed

# Add the latest updates to installed software
pkg.upgrade:
  module.run
