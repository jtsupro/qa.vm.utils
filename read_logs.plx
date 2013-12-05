#!/usr/bin/perl --
use strict;
use warnings;


if (@ARGV != 2) {
	print "Need to input path to log file and output log file\n";
	exit(0);
}

my $server_version = "";
my $proxy_version = "";
my $vm_name = "";
my $num_disks = 0;
my $logfile = shift;
my $passfail = "FAIL";

open(LOGFILE,$logfile) || die "Unable to open $logfile $!";

while(<LOGFILE>) {
	if ($_ =~ /START.*?(\d+\.\d+\.\d+\-\d+)/) {
		$proxy_version = $1;
	}

	$num_disks++ if $_ =~ /Prior Disk/;

	if ($_ =~ /0.*?errors, 0.*?fatal/) {
		$passfail = "PASS";
	}

}

close(LOGFILE);

my $outfile = shift;

open(OUTPUT,">$outfile");

print OUTPUT $proxy_version . "," . "$num_disks" . "," . "$passfail";

close(OUTPUT);

