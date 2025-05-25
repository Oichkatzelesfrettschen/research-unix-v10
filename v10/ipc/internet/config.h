#define GATEWAYS	"/usr/ipc/lib/gateways"
#define DKIPCONFIG	"/usr/ipc/mgrs/dkipconfig"
#define UTMP		"/etc/utmp"
#define LOGIN		"/etc/login"

/* byte transfer routines */
#include <string.h>
#define bcopy(f,t,l) memmove(t, f, l)
#define bzero(t,l) memset(t, 0, l)
