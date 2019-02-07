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
my $endatg;

$cpt = 0;
$frame = '.';

open (HMM, '<', "ghmm.out") or die "ghmm.out isn't in this file !\n";
open (GFF, '>', "ghmm.gff");

while(<HMM>)
{

    next if ($. <12); #selon le formatage de genmark, les CDS commencent toujours ligne 12
    $line = $_;

    @temp = split(/\s+/, $line); #on utilise le diviseur espace

    $cpt++; 
    $note = "GHMM_CDS_$cpt";
    $start = $temp[3];
    $end = $temp[4];
    $score = '';
    $brin = $temp[2];

    $endatg = $start + 2;
    $scoreatg = '';

    # on ecrit seulement si la ligne n'est pas vide
    print GFF "1_5404\tGenMark_HMM\tCDS\t$start\t$end\t$score\t$brin\t$frame\t$note\n" unless $temp[1] eq '';
    print GFF "1_5404\tGenMark_HMM\tATG\t$start\t$endatg\t$scoreatg\t$brin\t$frame\t.\n" unless $temp[1] eq '';
    
}

close(HMM);
close(GFF);