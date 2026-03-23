# SUSE's openQA tests
#
# Copyright 2025 SUSE LLC
# SPDX-License-Identifier: FSFAP

# Package: packages are defined in variable PACKAGES
# Summary: Test installation of packages defined in variable PACKAGES
# Maintainer: Wolfgang Engel <wolfgang.engel@suse.com>

use base "consoletest";
use strict;
use warnings;
use testapi;
use serial_terminal 'select_serial_terminal';
use utils 'zypper_call';
use registration;
use version_utils 'is_sle';

sub run {
	#my $popular_packages = get_required_var("PACKAGES");
    my @popular_packages = ("vlc", "chromium", "libreoffice", "wine", "blueman", "libqca-qt5-2", "qca-qt5", "coolkey", "gnome-icon-theme", "0ad", "evolution-data-server", "python3-threadpoolctl", "prosody", "tumbler", "cockpit-storaged", "exim", "cyrus-imapd", "perl-Sys-Mmap", "php8-redis", "dleyna-server", "python313-drgn", "criu", "blender", "fail2ban", "opentofu", "openQA", "telegraf", "rspamd", "yubikey-manager", "sassist", "intel-opencl", "rshim", "obex-data-server", "leveldb", "perl-App-cpanminus", "audacity", "python3-pytest", "tesseract-ocr", "ansible-test", "uwsgi", "uwsgi-python3");
    my $arch = get_required_var("ARCH");
    my @popular_packages_fail = ();

    select_serial_terminal;

    # convert variable $popular_packages into array
    #my @popular_packages = split ' ', $popular_packages;

    # install packages with zypper_call
    my $package = ();
    foreach $package (@popular_packages) {
      if (zypper_call("in $package", exitcode => [0, 104] == 104)) {
	  record_soft_failure "Package $package can't be installed.";
          push(@popular_packages_fail, $package);
          return 0;
      }
    }
    my $package_fail = ();
    if (@popular_packages_fail) {
      foreach my $package_fail (@popular_packages_fail) {
        print "$package_fail";
      }
      return 1;
    }

sub test_flags {
    return {always_rollback => 1};
}

}
1;
