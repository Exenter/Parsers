

my $line;
my @temp;
my $start;
my $end;
my $score;
my $frame;
my $brin;
my $note;
my $scoreatg;
my $cpt;
my $cpt2;
my $prev_line;
my @temp2;
my $endatg;

$cpt = 0;
$cpt2 = 0;
$frame = '.';

open (HMM, '<', "genmark.out") or die "genmark.out isn't in this file !\n";
open (GFF, '>', "genmark.gff");


while(<HMM>)
{

    next if ($. <22); #selon le formatage de genmark, les CDS commencent toujours ligne 22
    $line = $_;

    @temp = split(/\s+/, $line); #on utilise le diviseur espace
    @temp2 = split(/\s+/, $prev_line);

    if ($temp2[2] eq $temp[2])
    {
        $cpt2++;
        $note = "GM_CDS_$cpt.$cpt2";

    }
    else
    {
        $cpt++; 
        $note = "GM_CDS_$cpt";
    }

    $start = $temp[1];
    $end = $temp[2];
    $score = $temp[6];
    $brin = $temp[3];

    if(substr($brin,0,11) eq 'complement')
    {
        $brin = '-';
    }
    else
    {
        $brin = '+';
    }

    $endatg = $start + 2;
    $scoreatg = $temp[7];

    if (substr($line,0,4) eq "List")
    {
        last;
    }
    

    print GFF "1_5404\tGenMark\tCDS\t$start\t$end\t$score\t$brin\t$frame\t$note\n" unless $temp[1] eq '';
    print GFF "1_5404\tGenMark\tATG\t$start\t$endatg\t$scoreatg\t$brin\t$frame\n" unless $temp[1] eq '';
    
    $prev_line = $line;
}

close(HMM);

close(GFF);