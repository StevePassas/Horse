#create the Stables class
package Stable;
sub new
{
     my $class = shift;
     my $self =
     {
          _stableName => shift,
          _stableID => shift
     };
     #print "Stable Name is $self->{_stableName}\n";
     #print "Stable ID is $self->{_stableID}\n";
     bless $self, $class;
     return $self;   
}
=pod
sub eqls
{
     my($self, $number, $name) = @_;
     if(_stableID != $number)
     {
          return 0;
     }
     return $name eq _stableName;
}
=cut

sub getStableName
{
     my($self) = @_;
     return $self->{_stableName};
}
1;
