#This program reads a file containing a list of horse heigths and weights.
#It then calculates the mean height and weight of the horses in the list. 
#After that, it calculates the standard deviations of the heights and weights 
#of the horses in the list. 
#It them loads a list of stables and stores them as seperate classes.
#You can then enter your horse's height, weight, and the ID if the stable
#at which you keep your horse. If your stable is in the list, its name is 
#printed. Otherwise, "Other Stable" is printed. Then it compares your horse's
#height and weight to the mean of the other horses and tells you if your horse's
#height or weight is more than a standard deviation above or below the mean, or if
#your animal is possibly a giraffe.

use strict;
use warnings;
use Stable;
use Math::Complex;

#Open the horse Stats File
#Open it to read and append any new measurements
open FILE, "<", "HorseStats.dta" or die $!;
my $avgHeight = 0;
my $avgWeight = 0;
my $numMeas = 0;
my @heights;
my @weights;
my @stables;
my @stableList;
while(my $line = <FILE>)
{
     my @values = split(' ', $line);
     $avgHeight += $values[0];
     $avgWeight += $values[1];
     push(@heights, $values[0]);
     push(@weights, $values[1]);
     push(@stables, $values[2]);
}
$numMeas = @heights;
close FILE;
#Set Averages
$avgHeight /= $numMeas;
$avgWeight /= $numMeas;

#Print Averages
print "Average height: ";
printf '%.3f' , $avgHeight;
print ".\nAverage weight: ";
printf '%.3f', $avgWeight;
print "\n";

#Set and Print Standard Deviations
my $stDvHt = stDevHeight();
print "Height Standard Deviation: "; 
printf '%.3f',$stDvHt;
print "\n";
my $stDvWt = stDevWeight();
print "Weight Standard Deviation: ";
printf '%3f', $stDvWt;
print "\n";

#Get Stable Names
open FILE, "<", "Stables.dta" or die $!;
while(my $line = <FILE>)
{
     my @values = split(',', $line);
     my $stbl = new Stable($values[1], $values[0]);
     push(@stableList, $stbl);
     my $stn = $stbl->getStableName();     
}
close FILE;
#The user will enter the height and weight of the horse,
#then the stable ID
print "Enter Height in inches:\n";
my $height = readline STDIN;

chomp($height);

print "Enter Weight in pounds:\n";

my $weight = readline STDIN;
chomp($weight);

print "Enter Stable ID:\n";
my $stableID = readline STDIN;

my $numStables = @stableList;

#print stable name
if(($stableID < 1) || ($stableID > $numStables))
{
     print "Other Stable\n";
}
else
{
     my $stableName =$stableList[($stableID-1)]->getStableName();
     print "Stable: $stableName";
}

#print the height and its relation to the average(mean) within one standard deviation
print "Height: $height inches.\n";
if($height < ($avgHeight - $stDvHt) )
{
     print "Height significantly below average.\n";
}
elsif($height > ($avgHeight + $stDvHt) )
{
     print "Height significantly above average.\n";
}
else
{
     print "Height in average range.\n";
}

#print the weight and its relation to the mean within one standard deviation
print "Weight: $weight pounds.\n";
if($weight < ($avgWeight - $stDvWt))
{
     print "Weight significantly below average.\n";
}
elsif ($weight > ($avgWeight + $stDvWt))
{
     print "Weight significantly above average.\n";
}
else
{
     print "Weight in average range.\n"
}

if( ($height > 168 ) && ($weight > 1500) )
{
     print "This may be a giraffe.\n";
}

sub stDevHeight
{
     my $sd = 0;
     foreach my $val (@heights)
     {
          my $dev = $val - $avgHeight;
          $val *= 2;
          $sd += $val;
     }
     $sd /= ($numMeas-1);
     return sqrt($sd);
}

sub stDevWeight
{
     my $sd = 0;
     foreach my $val (@weights)
     {
          my $dev = $val - $avgWeight;
          $val *= 2;
          $sd += $val;
     }
     $sd /= ($numMeas-1);
     return sqrt($sd);
}
