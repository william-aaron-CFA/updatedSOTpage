#!/usr/bin/perl 

($hsec, $hmin, $hhour, $hmday, $hmon, $hyear, $hwday, $hyday, $hisdst)= localtime(time);
$year = $1900 + $hyear;
$mom  = $hmom  + 1;
$day  = $hmday + 1;

$dom2  = conv_date_dom($year, $mon, $day) -2;

open(OUT, "> bad_pix_list");

#
#---- previously unkonwn bad pixels
#
print OUT '<tr style="text-align:center"><td>Previously Unknown Bad Pixels</td>',"\n";
$test = `ls /data/mta_www/mta_bad_pixel/Disp_dir/totally_new*`;
for($i = 0; $i < 10; $i++){
	print OUT "<!-- ccd$i -->\n";
	print OUT "<td>\n";

	$name = 'totally_new'."$i";
	$cnt  = 0;
	if($name =~ /$test/){
		open(FH, "/data/mta_www/mta_bad_pixel/Disp_dir/$name");
		while(<FH>){
			chomp $_;
			@atemp = split(/\s+/, $_);
			print OUT "($atemp[0],$atemp[1])\n";
			$cnt++;
		}
		close(FH);
	}

	if($cnt == 0){
		print OUT '&#160',"\n";
	}
	print OUT "</td>\n";
}
print OUT "</tr>\n\n";

#
#---- current warm pixels
#

print OUT '<tr style="text-align:center"><td>Current Warm  Pixels</td>',"\n";
for($i = 0; $i < 10; $i++){
	print OUT "<!-- ccd$i -->\n";
	print OUT "<td>\n";
	$file = '/data/mta_www/mta_bad_pixel/Disp_dir/ccd'."$i";
	open(FH, "$file");
	$cnt  = 0;
    OUTER:
	while(<FH>){
		chomp $_;
		@atemp = split(/\s+/, $_);
        if($atemp[0] eq '' || $atemp[1] eq ''){
            next OUTER;
        }
		print OUT "($atemp[0],$atemp[1])\n";
		$cnt++;
	}
	close(FH);
	if($cnt == 0){
		print OUT '&#160',"\n";
	}
	print OUT "</td>\n";
}
print OUT "</tr>\n\n";

#
#---- flickering warm pixel
#

print OUT '<tr style="text-align:center"><td>Flickering Warm Pixels</td>',"\n";
for($i = 0; $i < 10; $i++){
	print OUT "<!-- ccd$i -->\n";
	print OUT "<td>\n";
	$file = '/data/mta_www/mta_bad_pixel/Disp_dir/flk_ccd'."$i";
	open(FH, "$file");
    $line = '';
	$cnt  = 0;
	while(<FH>){
		chomp $_;
		$line = $_;
	}
	close(FH);
	@atemp = split(/<>/, $line);
	if($atemp[0] >= $dom2){
        @btemp = split(/:/, $atemp[2]);
		foreach $ent (@btemp){
			print OUT "$ent\n";
			$j++;
			$cnt++;
		}
	}
	if($cnt == 0){
		print OUT '&#160',"\n";
	}
	print OUT "</td>\n";
}
print OUT "</tr>\n\n";


#
#---- current hot pixel
#

print OUT '<tr style="text-align:center"><td>Current Hot Pixels</td>',"\n";
$test = `ls /data/mta_www/mta_bad_pixel/Disp_dir/hccd*`;
for($i = 0; $i < 10; $i++){
	print OUT "<!-- ccd$i -->\n";
	print OUT "<td>\n";

	$name = 'hccd'."$i";
	$cnt  = 0;
	if($name =~ /$test/){
		open(FH, "/data/mta_www/mta_bad_pixel/Disp_dir/$name");
		while(<FH>){
			chomp $_;
			@atemp = split(/\s+/, $_);
			print OUT "($atemp[0],$atemp[1])\n";
			$cnt++;
		}
		close(FH);
	}

	if($cnt == 0){
		print OUT '&#160',"\n";
	}
	print OUT "</td>\n";
}
print OUT "</tr>\n\n";


#
#---- flickering hot pixel
#

$test = `ls /data/mta_www/mta_bad_pixel/Disp_dir/flk_hccd*`;

print OUT '<tr style="text-align:center"><td>Flickering Hot Pixels</td>',"\n";
for($i = 0; $i < 10; $i++){
	print OUT "<!-- ccd$i -->\n";
	print OUT "<td>\n";
	$file = '/data/mta_www/mta_bad_pixel/Disp_dir/flk_hccd'."$i";
	open(FH, "$file");
    $line = '';
	$cnt  = 0;
	while(<FH>){
		chomp $_;
		$line = $_;
	}
	close(FH);
	@atemp = split(/<>/, $line);
	if($atemp[0] >= $dom2){
        @btemp = split(/:/, $atemp[2]);
		foreach $ent (@btemp){
			print OUT "$ent ";
			$cnt++;
		}
	}
	if($cnt == 0){
		print OUT '&#160',"\n";
	}else{
        print OUT "\n";
    }
	print OUT "</td>\n";
}
print OUT "</tr>\n\n";

#
#---- warm column
#

print OUT '<tr style="text-align:center"><td>Warm column candidates</td>',"\n";
$test = `ls /data/mta_www/mta_bad_pixel/Disp_dir/col*`;
for($i = 0; $i < 10; $i++){
	print OUT "<!-- ccd$i -->\n";
	print OUT "<td>\n";

	$name = 'col'."$i";
	$cnt  = 0;
	if($name =~ /$test/){
		open(FH, "/data/mta_www/mta_bad_pixel/Disp_dir/$name");
		while(<FH>){
			chomp $_;
			@atemp = split(/\s+/, $_);
			print OUT "($atemp[0],$atemp[1])\n";
			$cnt++;
		}
		close(FH);
	}
	if($cnt == 0){
		print OUT '&#160',"\n";
	}

	print OUT "</td>\n";
}
print OUT "</tr>\n\n";

#
#---- flicerkingwarm column
#

print OUT '<tr style="text-align:center"><td>Flickering Warm Column Candidates</td>',"\n";
$test = `ls /data/mta_www/mta_bad_pixel/Disp_dir/flk_col*`;
for($i = 0; $i < 10; $i++){
	print OUT "<!-- ccd$i -->\n";
	print OUT "<td>\n";
	$file = '/data/mta_www/mta_bad_pixel/Disp_dir/flk_col'."$i";
	open(FH, "$file");
    $line = '';
	$cnt  = 0;
	while(<FH>){
		chomp $_;
		$line = $_;
	}
	close(FH);
	@atemp = split(/<>/, $line);
	if($atemp[0] >= $dom2){
        @btemp = split(/:/, $atemp[2]);
		OUTER:
		foreach $ent (@btemp){
			print OUT "$ent ";
			$cnt++;
		}
	}
	if($cnt == 0){
		print OUT '&#160',"\n";
	}else{
        print OUT "\n";
    }
	print OUT "</td>\n";
}
print OUT "</tr>\n\n";

print OUT "</table>\n";



				
		
	





###########################################################################
###      conv_date_dom: modify data/time format                       #####
###########################################################################

sub conv_date_dom {

#############################################################
#       Input:  $year: year in a format of 2004
#               $month: month in a formt of  5 or 05
#               $day:   day in a formant fo 5 05
#
#       Output: acc_date: day of mission returned
#############################################################

        my($year, $month, $day, $chk, $acc_date);

        ($year, $month, $day) = @_;

        $acc_date = ($year - 1999) * 365;

        if($year > 2000 ) {
                $acc_date++;
        }elsif($year >  2004 ) {
                $acc_date += 2;
        }elsif($year > 2008) {
                $acc_date += 3;
        }elsif($year > 2012) {
                $acc_date += 4;
        }elsif($year > 2016) {
                $acc_date += 5;
        }

        $acc_date += $day - 1;
        if ($month == 2) {
                $acc_date += 31;
        }elsif ($month == 3) {
                $chk = 4.0 * int(0.25 * $year);
                if($year == $chk) {
                        $acc_date += 59;
                }else{
                        $acc_date += 58;
                }
        }elsif ($month == 4) {
                $acc_date += 90;
        }elsif ($month == 5) {
                $acc_date += 120;
        }elsif ($month == 6) {
                $acc_date += 151;
        }elsif ($month == 7) {
                $acc_date += 181;
        }elsif ($month == 8) {
                $acc_date += 212;
        }elsif ($month == 9) {
                $acc_date += 243;
        }elsif ($month == 10) {
                $acc_date += 273;
        }elsif ($month == 11) {
                $acc_date += 304;
        }elsif ($month == 12) {
                $acc_date += 334;
        }
        $acc_date -= 202;
        return $acc_date;
}

