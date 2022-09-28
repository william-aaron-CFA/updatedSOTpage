#!/usr/bin/perl

#########################################################################################
#											#
#	subst.perl: create a base weekly report from a template				#
#											#
#		author: t. isobe (tisobe@cfa.harvard.edu)				#
#											#
#		last update: Oct 26, 2009						#
#											#
#########################################################################################

$bad_pix    = $ARGV[0];
$telem      = $ARGV[1];
$angle      = $ARGV[2];
$photon     = $ARGV[3];

if($bad_pix eq '' || $bad_pix =~ /h/i){
    print "USAGE: perl subst.perl <bad_pix> <telem> <pitch_angle> <photon>\n";
    exit 1;
}

$org_text = `cat /data/mta4/www/REPORTS/Template/template.html`;

$insert = `cat $bad_pix`;
$org_text =~s/BAD_PIXEL_TABLE/$insert/;

$insert = `cat $telem`;
$org_text =~s/TELEM_TABLE/$insert/;

$insert = `cat $angle`;
$org_text =~s/ANGLE_TABLE/$insert/;

$insert = `cat $photon`;
$org_text =~s/PHOTON_TABLE/$insert/;

print "$org_text";
