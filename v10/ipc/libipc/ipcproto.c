#include <sys/types.h>
#include <sys/filio.h>
#include <pwd.h>
#include <ipc.h>
#include <libc.h>
#include "defs.h"
#include "spinlock.h"
extern spinlock_t ipc_lock;

/* buffer definition */
#define BUFLEN 512

/* have to define this somewhere */
char *ipcname;

/*
 *  Recieve an fd
 */
ipc_status
_fd_read(onfd, pp)
        int onfd;
        struct passfd *pp;
{
        if (ioctl(onfd, FIORCVFD, pp) < 0) {
                if(errno == ETIMEDOUT)
                        return IPC_STATUS_TIMEOUT;
                if(errno == EAGAIN || errno == EWOULDBLOCK)
                        return IPC_STATUS_QUEUE_FULL;
                if(errno == ENOENT || errno == EINVAL)
                        return IPC_STATUS_INVALID_TARGET;
                return IPC_STATUS_ERROR;
        }
        return IPC_STATUS_SUCCESS;
}

/*
 *  Send an fd
 */
ipc_status
_fd_write(onfd, tofd)
{
        if (ioctl(onfd, FIOSNDFD, &tofd) < 0) {
                if(errno == ETIMEDOUT)
                        return IPC_STATUS_TIMEOUT;
                if(errno == EAGAIN || errno == EWOULDBLOCK)
                        return IPC_STATUS_QUEUE_FULL;
                if(errno == ENOENT || errno == EINVAL)
                        return IPC_STATUS_INVALID_TARGET;
                return IPC_STATUS_ERROR;
        }
        return IPC_STATUS_SUCCESS;
}

/*
 *  convert an int to a signed string
 */
static char *
itoa(n)
	int n;
{
	static char num[64];
	char bw[64];
	char *bp, *np;

	np = num;
	if(n < 0){
		*np++ = '-';
		n = -n;
	}
	for(bp = bw; n; n = n/10)
		*bp++ = (n % 10) + '0';
	while(bp > bw)
		*np++ = *--bp;
	*np = 0;
	return num;
}

/*
 *  Send the connection info.
 */
ipc_status
_info_write(fd, ip)
	int fd;
	ipcinfo *ip;
{
	char b[BUFLEN];
	int n;

	if (ip->name==NULL)
		ip->name = "";
	if (ip->param==NULL)
		ip->param = "";
	if (ip->machine==NULL)
		ip->machine = "";
	if (ip->user==NULL)
		ip->user = "";
	if (ip->myname==NULL)
		ip->myname = "";
	strcpy(b, ip->myname);
	strcat(b, "\n");
	strcat(b, ip->name);
	strcat(b, "\n");
	strcat(b, ip->param);
	strcat(b, "\n");
	strcat(b, ip->machine);
	strcat(b, "\n");
	strcat(b, ip->user);
	strcat(b, "\n");
	strcat(b, itoa(ip->flags));
	strcat(b, "\n");
	strcat(b, itoa(ip->uid));
	strcat(b, "\n");
	strcat(b, itoa(ip->gid));
	strcat(b, "\n");
        n = strlen(b);
        if (write(fd, b, n)!=n) {
                ABORT(errno, "can't send request", NULLINFO);
                if(errno == ETIMEDOUT)
                        return IPC_STATUS_TIMEOUT;
                if(errno == EAGAIN || errno == EWOULDBLOCK)
                        return IPC_STATUS_QUEUE_FULL;
                if(errno == ENOENT || errno == EINVAL)
                        return IPC_STATUS_INVALID_TARGET;
                return IPC_STATUS_ERROR;
        }
        return IPC_STATUS_SUCCESS;
}

/*
 *  Read the connection info.  If an error occurs, ip->reply and ip->conn are
 *  closed.
 */
ipc_status
_info_read(fd, ip)
	int fd;
	ipcinfo *ip;
{
	static char b[BUFLEN];
	char *f[8];
	int n;
	char *oldfields;

        n=read(fd, b, sizeof(b));
        if (n <= 0) {
                ABORT(errno, "error reading request", ip);
                if(errno == ETIMEDOUT)
                        return IPC_STATUS_TIMEOUT;
                if(errno == EAGAIN || errno == EWOULDBLOCK)
                        return IPC_STATUS_QUEUE_FULL;
                if(errno == ENOENT || errno == EINVAL)
                        return IPC_STATUS_INVALID_TARGET;
                return IPC_STATUS_ERROR;
        }
	b[n] = '\0';
	oldfields = setfields("\n");
	if (getfields(b, f, 8)!=8){
                setfields(oldfields);
                ABORT(EINVAL, "protocol botch", ip);
                return IPC_STATUS_INVALID_TARGET;
        }
	ip->myname = f[0];
	ip->name = f[1];
	ip->param = f[2];
	ip->machine = f[3];
	ip->flags = atoi(f[5]);

	/* supply a system name */
	if (ip->uid!=ROOTUID || ip->machine[0]=='\0')
		ip->machine = "";

	/* supply a user name */
	if (ip->uid==ROOTUID && *(f[4])!='\0')
		ip->user = f[4];

	/* supply uid/gid cruft */
	if (ip->uid==ROOTUID && atoi(f[6])!=-1) {
		ip->uid = atoi(f[6]);
		ip->gid = atoi(f[7]);
	}
        setfields(oldfields);
        return IPC_STATUS_SUCCESS;
}

/*
 *  Send a reply to a connection request
 */
ipc_status
_reply_write(fd, no, str)
	int fd;
	int no;
	char *str;
{
	char b[BUFLEN];
	int n;

	if (str==NULL)
		str = "";
	strcpy(b, itoa(no));
	strcat(b, "\n");
	strcat(b, str);
	strcat(b, "\n");
        n = strlen(b);
        if (write(fd, b, n)!=n) {
                if(errno == ETIMEDOUT)
                        return IPC_STATUS_TIMEOUT;
                if(errno == EAGAIN || errno == EWOULDBLOCK)
                        return IPC_STATUS_QUEUE_FULL;
                if(errno == ENOENT || errno == EINVAL)
                        return IPC_STATUS_INVALID_TARGET;
                return IPC_STATUS_ERROR;
        }
        return IPC_STATUS_SUCCESS;
}

/*
 *  Get a reply to a connection request.
 */
ipc_status
_reply_read(fd)
	int fd;
{
	static char b[BUFLEN];
	char *f[2];
	char *ptr;
	int n;

        while((n=read(fd, b, sizeof(b)))<0 && errno==EINTR)
                ;
        if (n <= 0) {
                ABORT(errno, "error reading request", NULLINFO);
                if(errno == ETIMEDOUT)
                        return IPC_STATUS_TIMEOUT;
                if(errno == EAGAIN || errno == EWOULDBLOCK)
                        return IPC_STATUS_QUEUE_FULL;
                if(errno == ENOENT || errno == EINVAL)
                        return IPC_STATUS_INVALID_TARGET;
                return IPC_STATUS_ERROR;
        }
	b[n] = '\0';
	setfields("\n");
	getfields(b, f, 2);
	errno = atoi(f[0]);
	if ((ptr=strchr(f[1], '\n'))!=NULL)
		*ptr = '\0';
       if (errno!=0) {
               spin_lock(&ipc_lock);
               errstr = f[1];
               spin_unlock(&ipc_lock);
       } else {
               spin_lock(&ipc_lock);
               ipcname = f[1];
               spin_unlock(&ipc_lock);
       }
       return IPC_STATUS_SUCCESS;
}

