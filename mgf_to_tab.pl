#!/usr/bin/perl

my $line;
my @temp;
my @spectre;
my @intensity1;
my @intensity2;
my @intensity3;
my @intensity4;
my @tag1;
my @tag2;
my @tag3;
my @tag4;
my @cpt;
my @file_name;

# ----- This parser takes as arguments a file name and 1 to 4 tags to search in the given mgf file
# -- could be improved with a loop to use a given number of tags


# gather tags and file name
$file_name = $ARGV[0];
$tag1 = $ARGV[1];
$tag2 = $ARGV[2];
$tag3 = $ARGV[3];
$tag4 = $ARGV[4];

# init a counter to 0, use it to increment spectre name ..
$cpt = 0;

# open files ..
open (OUTPUT, '>', "parsed_mgf.txt");
open (FILE, '<', "$file_name") or die "$file_name isn't in this file !\n";

# writing header ..
print OUTPUT "Spectre\t$tag1\t$tag2\t$tag3\t$tag4\n";

# parsing file ..
while(<FILE>)
{

    $line = $_;
    @temp = split(/\s+/, $line); # split line using space as a delimiter, store as a list

    if (substr($line,0,5) eq 'BEGIN')
    {        
        $cpt++;
        $spectre = "Spectre_$cpt";
        $intensity1 = "NA";	# init intensities to NA so R understands there is no value
        $intensity2 = "NA";
        $intensity3 = "NA";
        $intensity4 = "NA";
    }

    if ($temp[0] > $tag1-0.06 ) # give a range of +/- 0.05
    {
        if ($temp[0] < $tag1+0.06)
        {
            if ($tag1-$temp[0] < $tag1-$intensity1) # minimise the diff betwen what we found and what we want
            {
                $intensity1 = $temp[1];
            }
            
        }
    }

    if ($temp[0] > $tag2-0.06)
    {
        if ($temp[0] < $tag2+0.06)
        {
            if ($tag2-$temp[1] < $tag2-$intensity2)
            {
                $intensity2 = $temp[1];
            }
            
        }
    }

    if ($temp[0] > $tag3-0.06)
    {
        if ($temp[0] < $tag3+0.06)
        {
            if ($tag3-$temp[1] < $tag3-$intensity3)
            {
                $intensity3 = $temp[1];
            }
            
        }
    }

    if ($temp[0] > $tag4-0.06)
    {
        if ($temp[0] < $tag4+0.06)
        {
            if ($tag4-$temp[1] < $tag4-$intensity4)
            {
                $intensity4 = $temp[1];
            }
            
        }
    }

    if (substr($line,0,3) eq 'END') # end = end of actual spectre = we can write down the infos
    {
        print OUTPUT "$spectre\t$intensity1\t$intensity2\t$intensity3\t$intensity4\n";
    }    
}
close(FILE);
