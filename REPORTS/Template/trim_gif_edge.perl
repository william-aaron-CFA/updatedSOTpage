#!/usr/bin/perl

#########################################################################################
#                                                                                       #
#   trim_gif_edge.perl: this script trims blank part of gif file.                       #
#                                                                                       #
#       author: t. isobe (tisobe@cfa.harvard.edu)                                       #
#                                                                                       #
#       last update Nov. 6, 2009                                                        #
#                                                                                       #
#########################################################################################

$file  = $ARGV[0];
chomp $file;

#
#-- if no file is given, scan the directory and do for all gif files.
#

if($file eq ''){
    $input = `ls *gif *png`;
    @list = split(/\s+/, $input);
}else{
    @list = ("$file");
}

foreach $input_img (@list){
	if($input_img =~ /.gif/){
		system("giftopnm $input_img |pnmcrop |ppmtogif  > out.gif");
		system("mv out.gif $input_img");
	}elsif($input_img =~ /.png/){
		system("pngtopnm $input_img |pnmcrop |ppmtogif  > out.gif");
		$input_img =~ s/png/gif/;
		system("mv out.gif $input_img");
	}
}




