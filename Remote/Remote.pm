package Audacious::Remote;

use 5.005;
use strict;
use DynaLoader ();

{
    no strict;
    @ISA = qw(DynaLoader);
    $VERSION = '0.03';
    __PACKAGE__->bootstrap($VERSION);
}

sub all_win_toggle {
    my($remote, $show) = @_;
    for (qw(main pl eq)) {
        my $meth = "${_}_win_toggle";
        my $is = "is_${_}_win";
        next if $remote->$is() == $show;
        $remote->$meth($show);
    }
}

1;
__END__

=head1 NAME

Audacious::Remote - Perl Interface to Audacious's remote API

=head1 SYNOPSIS

  use Audacious::Remote ();
  my $remote = Audacious::Remote->new;
  $remote->play;

=head1 DESCRIPTION

This module provides a Perl interface to the audacious remote control interface.
No docs yet, sorry, see test.pl and Audacious.pm for now

=head1 SEE ALSO

xmms(1), Audacious(3), MPEG::MP3Info(3)

=head1 AUTHOR

Doug MacEachern

=cut
