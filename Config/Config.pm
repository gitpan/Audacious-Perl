package Audacious::Config;

use 5.005;
use strict;
use DynaLoader ();

{
    no strict;
    @ISA = qw(DynaLoader);
    $VERSION = '0.01';
    __PACKAGE__->bootstrap($VERSION);
}

1;
__END__

=head1 NAME

Audacious::Config - Perl Interface to xmms_cfg API

=head1 SYNOPSIS

 my $file = Audacious::Config->file; #$ENV{HOME}/.audacious/config
 my $cfg = Audacious::Config->new($file);

=head1 DESCRIPTION

=head1 AUTHOR

Doug MacEachern

=head1 SEE ALSO

xmms(1), Audacious::Remote(3)

=cut
