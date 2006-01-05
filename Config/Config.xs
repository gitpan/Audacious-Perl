#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "audacious/configfile.h"

typedef ConfigFile * Audacious__Config;

#define xmms_cfg_DESTROY xmms_cfg_free
#define xmms_cfg_write   xmms_cfg_write_string

MODULE = Audacious::Config   PACKAGE = Audacious::Config   PREFIX = xmms_cfg_

PROTOTYPES: disable

SV *
xmms_cfg_file(self)
    SV *self

    CODE:
    RETVAL = newSV(0);
    sv_setpvf(RETVAL, "%s/.audacious/config", g_get_home_dir());

    OUTPUT:
    RETVAL

SV *
xmms_cfg_perlfile(self)
    SV *self

    CODE:
    RETVAL = newSV(0);
    sv_setpvf(RETVAL, "%s/.audacious/config.perl", g_get_home_dir());

    OUTPUT:
    RETVAL

Audacious::Config
xmms_cfg_new(svclass, filename=NULL)
    SV *svclass
    gchar *filename

    CODE:
    RETVAL = NULL;
    if (filename) {
	RETVAL = xmms_cfg_open_file(filename);
    }
    if (!RETVAL) {
	RETVAL = xmms_cfg_new();
    }

    OUTPUT:
    RETVAL

void
xmms_cfg_DESTROY(cfg)
    Audacious::Config cfg

gboolean
xmms_cfg_write_file(cfg, filename)
    Audacious::Config cfg
    gchar *filename

void
xmms_cfg_remove_key(cfg, section, key)
    Audacious::Config cfg
    gchar *section
    gchar *key

SV *
xmms_cfg_read(cfg, section, key)
    Audacious::Config cfg
    gchar *section
    gchar *key

    PREINIT:
    gchar *value;

    CODE:
    if (!xmms_cfg_read_string(cfg, section, key, &value)) {
	XSRETURN_UNDEF;
    }
    RETVAL = newSV(0);
    sv_setpv(RETVAL, value);
    g_free(value);

    OUTPUT:
    RETVAL

void
xmms_cfg_write(cfg, section, key, value)
    Audacious::Config cfg
    gchar *section
    gchar *key
    gchar *value
