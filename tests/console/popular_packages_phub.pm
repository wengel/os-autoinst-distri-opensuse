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
    my $arch = get_required_var("ARCH");
    my @popular_packages = split(',', get_required_var("POPULAR_PACKAGES"));
    my @popular_patterns = split(',', get_required_var("POPULAR_PATTERNS"));
    my @popular_packages_fail = ();
    my @popular_patterns_fail = ();

    select_serial_terminal;

    # install packages with zypper_call
    my $package = ();
    foreach $package (@popular_packages) {
      if ((zypper_call("in $package", exitcode => [0, 4, 104]) != 0)) {
	  record_info($package);
	  #record_soft_failure("Package $package can't be installed.");
          push(@popular_packages_fail, $package);
      }
    }
    my $pattern = ();
    foreach $pattern (@popular_patterns) {
      if ((zypper_call("in -t pattern $pattern", exitcode => [0, 4, 104]) != 0)){
        record_info($pattern);
	push(@popular_patterns_fail, $pattern);
      }
    }
    my $package_fail = ();
    if (@popular_packages_fail) {
      foreach my $package_fail (@popular_packages_fail) {
        print "$package_fail";
      }
      record_soft_failure("Failed to install package(s): @popular_packages_fail");
      return;
    }
    my $pattern_fail = ();
    if (@popular_patterns_fail) {
      foreach my $Pattern_fail (@popular_patterns_fail){
        print "$pattern_fail";
      }
      record_soft_failure("Failed to install pattern(s): @popular_patterns_fail");
      return;
    }


sub test_flags {
    return {always_rollback => 0};
}

}
1;
