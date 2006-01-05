use 5.005;
use ExtUtils::MakeMaker;
use lib qw(./lib ../lib);
use Audacious::ExtUtils ();

$inc = Audacious::ExtUtils::inc();
$libs = Audacious::ExtUtils::libs();

WriteMakefile(
    'NAME'	=> 'Audacious::Config',
    'VERSION_FROM' => 'Config.pm',
    'LIBS'	=> [$libs],
    'INC'	=> $inc,
);
