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

# ----- This parser takes as arguments a file name and 1 to 4 tags to search in the given mgf file.


# gather tags and file name
$file_name = $ARGV[0];
$tag1 = $ARGV[1];
$tag2 = $ARGV[2];
$tag3 = $ARGV[3];
$tag4 = $ARGV[4];

# init a counter to 0, use it to increment spectre name
$cpt = 0;

open (OUTPUT, '>', "parsed_mgf.txt");
open (FILE, '<', "$file_name") or die "$file_name isn't in this file !\n";

while(<FILE>)
{

    $line = $_;
    @temp = split(/\s+/, $line); #on utilise le diviseur espace

    if (substr($line,0,5) eq 'BEGIN')
    {        
        $cpt++;
        $spectre = "Spectre_$cpt";
        $intensity1 = 0;
        $intensity2 = 0;
        $intensity3 = 0;
        $intensity4 = 0;
    }

    if ($temp[0] > $tag1-0.06 )
    {
        if ($temp[0] < $tag1+0.06)
        {
            if ($tag1-$temp[0] < $tag1-$intensity1)
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

    if (substr($line,0,3) eq 'END')
    {
        print OUTPUT "$spectre\t$intensity1\t$intensity2\t$intensity3\t$intensity4\n";
    }    
}
close(FILE);
