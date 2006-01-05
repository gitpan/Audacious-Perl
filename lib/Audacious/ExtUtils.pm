package Audacious::ExtUtils;

use strict;
use Config;
use DynaLoader ();

sub inc {
    my @inc;

    for my $cflags (`pkg-config --cflags audacious`,
                    `glib-config --cflags`)
    {
        next unless $cflags;
        chomp $cflags;
        push @inc, $cflags;
    }

    "@inc";
}

my @XFree86 = qw(-lXxf86vm -lXxf86dga -lXxf86misc);

sub libs {
    chomp(my $libs = `pkg-config --libs audacious`);
    $libs ||= "-L/usr/X11R6/lib -lgtk -lgdk -lglib -lX11 -lXext";
    $libs =~ s/-rdynamic//;
    for (split /\s+/, $Config{libpth}) {
	if (DynaLoader::dl_findfile($_, $XFree86[0])) {
	    $libs .= " @XFree86";
	    last;
	}
    }
    $libs;
}

1;
__END__
