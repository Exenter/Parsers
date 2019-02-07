my $line;
my @temp;
my $start;
my $end;
my $brin;
my $motif;
my $feature;
my $note;

open (MOTIF, '>', "motifs.gff");

$note = 'note';

#-------------------------PROMOTEUR ET COMPLEMENTAIRE--------------------------------

open (PROM, '<', "prom_seq1.txt") or die "prom_seq1.txt isn't in this file !\n";

while(<PROM>)
{
    $feature = 'promoter';
    $brin = '+';
    $line = $_;

    if (substr($line,0,1) eq '>')
    {
        if ($line =~ /^>\d_\d+:\[(\d+),(\d+)\]$/) 
        {
	        $start = $1;
            $end = $2;
            print MOTIF "1_5404\tPatScan\t$feature\t$start\t$end\t.\t$brin\t.\t$note";            
        }
    }
    else
    {
        $motif = $line;
        print MOTIF "\t$motif\n";
    }
    
}
close(PROM);

open (PROMCOMP, '<', "prom_seq1_comp.txt") or die "prom_seq1_comp.txt isn't in this file !\n";

while(<PROMCOMP>)
{
    $feature = 'promoter';
    $brin = '-';
    $line = $_;

    if (substr($line,0,1) eq '>')
    {
        if ($line =~ /^>\d_\d+:\[(\d+),(\d+)\]$/) 
        {
	        $start = $2;    # sur le brin complementaire les positions sont inversees
            $end = $1;
            print MOTIF "1_5404\tPatScan\t$feature\t$start\t$end\t.\t$brin\t.\t$note";            
        }
    }
    else
    {
        $motif = $line;
        print MOTIF "\t$motif\n";
    }
    
}
close(PROMCOMP);

#---------------------------RBS ET COMPLEMENTAIRE---------------------------------

open (RBS, '<', "rbs_seq1.txt") or die "rbs_seq1.txt isn't in this file !\n";

while(<RBS>)
{
    $feature = 'RBS';
    $brin = '+';
    $line = $_;

    if (substr($line,0,1) eq '>')
    {
        if ($line =~ /^>\d_\d+:\[(\d+),(\d+)\]$/) 
        {
	        $start = $1;
            $end = $2;
            print MOTIF "1_5404\tPatScan\t$feature\t$start\t$end\t.\t$brin\t.\t$note";            
        }
    }
    else
    {
        $motif = $line;
        print MOTIF "\t$motif\n";
    }
    
}
close(RBS);

open (RBSCOMP, '<', "rbs_seq1_comp.txt") or die "rbs_seq1_comp.txt isn't in this file !\n";

while(<RBSCOMP>)
{
    $feature = 'RBS';
    $brin = '-';
    $line = $_;

    if (substr($line,0,1) eq '>')
    {
        if ($line =~ /^>\d_\d+:\[(\d+),(\d+)\]$/) 
        {
	        $start = $2;
            $end = $1;
            print MOTIF "1_5404\tPatScan\t$feature\t$start\t$end\t.\t$brin\t.\t$note";            
        }
    }
    else
    {
        $motif = $line;
        print MOTIF "\t$motif\n";
    }
    
}
close(RBSCOMP);

#---------------------------TERMINATEUR ET COMPLEMENTAIRE-----------------------------

open (TERM, '<', "term_seq1.txt") or die "term_seq1.txt isn't in this file !\n";

while(<TERM>)
{
    $feature = 'terminator';
    $brin = '+';
    $line = $_;

    if (substr($line,0,1) eq '>')
    {
        if ($line =~ /^>\d_\d+:\[(\d+),(\d+)\]$/) 
        {
	        $start = $1;
            $end = $2;
            print MOTIF "1_5404\tPatScan\t$feature\t$start\t$end\t.\t$brin\t.\t$note";            
        }
    }
    else
    {
        $motif = $line;
        print MOTIF "\t$motif\n";
    }
    
}
close(TERM);

open (TERMCOMP, '<', "term_seq1_comp.txt") or die "term_seq1_comp.txt isn't in this file !\n";

while(<TERMCOMP>)
{
    $feature = 'terminator';
    $brin = '-';
    $line = $_;

    if (substr($line,0,1) eq '>')
    {
        if ($line =~ /^>\d_\d+:\[(\d+),(\d+)\]$/) 
        {
	        $start = $2;
            $end = $1;
            print MOTIF "1_5404\tPatScan\t$feature\t$start\t$end\t.\t$brin\t.\t$note";            
        }
    }
    else
    {
        $motif = $line;
        print MOTIF "\t$motif\n";
    }
    
}
close(TERMCOMP);

close(MOTIF);