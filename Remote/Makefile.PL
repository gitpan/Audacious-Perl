use 5.005;
use ExtUtils::MakeMaker;
use lib qw(./lib ../lib);
use Audacious::ExtUtils ();
use DynaLoader ();

$inc  = Audacious::ExtUtils::inc();
$libs = Audacious::ExtUtils::libs();

my(@libpath) = qw(-L/usr/X11/lib -L/usr/local/lib -L/usr/lib);
my $has_add_url = 0;
my $has_delete  = 0;

for (@libpath) {
    my $file = DynaLoader::dl_findfile($_, "-laudacious");
    $seen{$file}++;
    #audacious doesn't have a way to determine this support via include files??
    my $libref = DynaLoader::dl_load_file($file, DynaLoader->dl_load_flags);
    $has_add_url ||= DynaLoader::dl_find_symbol($libref, 
			         "xmms_remote_playlist_add_url_string");
    $has_delete  ||= DynaLoader::dl_find_symbol($libref, 
			         "xmms_remote_playlist_delete");
}

$inc .= " -DHAS_ADD_URL" if $has_add_url;
$inc .= " -DHAS_DELETE" if $has_delete;

if (keys %seen > 1) {
    print "*" x 40, $/;
    print "WARNING: more than one libaudacious found:\n";
    print map "   $_\n", keys %seen;
    print "You might want to un-install the old version\n";
    print "*" x 40, $/;
}

WriteMakefile(
    'NAME'	=> 'Audacious::Remote',
    'VERSION_FROM' => 'Remote.pm',
    'LIBS'	=> [$libs],
    'INC'	=> $inc,
);
