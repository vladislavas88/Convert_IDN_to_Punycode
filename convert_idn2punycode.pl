#!/usr/bin/env perl 

=pod

=head1 Using the script for convert idn to punycode
#===============================================================================
#
#         FILE: convert_idn2punycode.pl
#
#        USAGE: $ sudo dnf install perl-Net-IDN-Encode
#        		
#        		$ touch ./idn_list
#        		москва.рф 
#
#        		$ ./convert_idn2punycode.pl idn_list
#				
#				Converting IDN to Punycode successfully!
#				Squid reload successfully!        		
#
#        		$ cat /home/admin/url_allow_whitelist1.lst'  
#				xn--80adxhks.xn--p1ai
#
#  DESCRIPTION: Script for convert idn to punycode
#
#      OPTIONS: ---
# REQUIREMENTS: Perl v5.14+
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Vladislav Sapunov  
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 09.01.2024 12:18:18
#     REVISION: ---
#===============================================================================
=cut

use strict;
use warnings;
use v5.14;
use utf8;
use Net::IDN::Encode ':all';
use open ':encoding(UTF-8)';

my $aclList = '/home/admin/url_allow_whitelist1.lst';

open( FHW, '>>', $aclList ) or die "Couldn't Open file $aclList" . "$!\n";

while ( defined( my $line = <> ) ) {
    chomp($line);
    my $idn = domain_to_ascii($line);
    chomp($idn);
    say FHW $idn;
}

close(FHW) or die "$!\n";

say "Converting IDN to Punycode successfully!";

system("service squid reload");

say "Squid reload successfully!";

