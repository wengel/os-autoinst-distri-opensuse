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
    my $popular_packages = get_required_var("PACKAGES");
    my $arch = get_required_var("ARCH");

    select_serial_terminal;

    # convert variable $popular_packages into array
    my @popular_packages = split ' ', $popular_packages;

    # install packages with zypper_call
    foreach $package (@popular_packages)
    {
      zypper_call "in $package";
    }

}

sub test_flags {
    return {always_rollback => 1};
}

1;
