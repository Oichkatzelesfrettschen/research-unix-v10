#include <stdio.h>
#include <errno.h>
#include <fio.h>
#include <libc.h>
#include "ipc.h"
#include "spinlock.h"
extern spinlock_t ipc_lock;

extern char *strchr(), *malloc();
static Qtuple *tuples();
static int nsreply();
static int nscall();

/*
 *  return a set of tuples
 */
Qset *
qset(tuplestr, nameserver)
	char *tuplestr;
	char *nameserver;
{
	int fd;
	char *cp;
	Qset *top = NULL;
	Qset *last = NULL;
	Qset *ps;
	Qtuple *t;

	/*
	 *  get connection to name server
	 */
	if((fd = nscall(nameserver))<0)
		return NULL;
	
	/*
	 *  send request to name server
	 */
	fprint(fd, "set %s\n", tuplestr);

	/*
	 *  parse reply code
	 */
	if(nsreply(fd)<0){
		close(fd);
		return NULL;
	}

	/*
	 *  Parse returned tuples.  Each starts with a tab and ends
	 *  with a new line.
	 */
	while((cp = Frdline(fd))!=NULL){
		errno = 0;
		if(*cp++!='\t')
			break;
		if((t = tuples(cp)) == NULL)
			break;
               if(!(ps = (Qset *)malloc(sizeof(Qset)))) {
                       if(ps!=NULL)
                               freeQset(ps);
                       spin_lock(&ipc_lock);
                       errstr = "no more memory";
                       spin_unlock(&ipc_lock);
                       errno = ENOMEM;
                       break;
               }
		ps->this = t;
		if(last) last->next = ps;
		else {
			top = ps;
		}
		last = ps;
		ps->next = NULL;
	}
	close(fd);
	return top;
}

/*
 *  return a single value
 */
char *
qvalue(types, tuplestr, nameserver)
	char *types;
	char *tuplestr;
	char *nameserver;
{
	int fd;
	static char rv[512];
	char *vp;

	/*
	 *  get connection to name server
	 */
	if((fd = nscall(nameserver))<0)
		return NULL;
	
	/*
	 *  send request to name server
	 */
	fprint(fd, "value %s %s\n", types, tuplestr);

	/*
	 *  parse reply code
	 */
	if(nsreply(fd)<0){
		close(fd);
		return NULL;
	}

	vp = Frdline(fd);
	close(fd);
       if(vp==NULL){
               errno = EBUSY;
               spin_lock(&ipc_lock);
               errstr = "malfunction";
               spin_unlock(&ipc_lock);
               return NULL;
       }
	errno = 0;
	if(*vp++!='\t')
		return NULL;
	strcpy(rv, vp);
	return rv;
}

/*
 *  get connection to name server
 */
static int
nscall(nameserver)
	char *nameserver;
{
	int fd;

       if(nameserver && *nameserver)
               fd = ipcopen(nameserver, "");
       else
               fd = ipcopen("/cs/ns", "");
       if(fd<0) {
               spin_lock(&ipc_lock);
               errstr = "can't contact nameserver";
               spin_unlock(&ipc_lock);
               errno = EBUSY;
               return -1;
       }
	return fd;
}

/*
 *  get and parse reply code
 */
static int
nsreply(fd)
	int fd;
{
	char *cp;

       Finit(fd, (char *)0);
       if((cp = Frdline(fd))==NULL) {
               spin_lock(&ipc_lock);
               errstr = "name server gave up";
               spin_unlock(&ipc_lock);
               errno = EBUSY;
               return -1;
       }
	if(strncmp("OK", cp, 2)==0){
		/* all's well */
       } else if(strncmp("BUSY", cp, 4)==0){
               spin_lock(&ipc_lock);
               errstr = "name server busy";
               spin_unlock(&ipc_lock);
               errno = EBUSY;
               return -1;
       } else if(strncmp("ILL", cp, 3)==0){
               spin_lock(&ipc_lock);
               errstr = "illegal request";
               spin_unlock(&ipc_lock);
               errno = EINVAL;
               return -1;
       } else {
               spin_lock(&ipc_lock);
               errstr = "unknown response from name server";
               spin_unlock(&ipc_lock);
               errno = EBUSY;
               return -1;
       }
	return 0;
}

/*
 *  parse a linear tuple into the Qtuple data structure
 */
static Qtuple *
tuples(buf)
char *buf;
{
	Qtuple *t, *first = NULL, *last = NULL;
	char *tups[200];
	register char *value,*type;
	int n,k;
	char *oldfields;

	if((value = strchr(buf,'\n')))
		*value = 0;
	oldfields = setfields(" \t");
	n = getmfields(buf,tups,200);
	for(k = 0; k < n; k++) {
		if((type = strchr(tups[k],',')))
			*type++ = 0;
		else
			type = NULL;
		value = tups[k];

		if((t = (Qtuple *) malloc(sizeof(Qtuple)))==NULL)
			goto err;
		if(first==NULL)
			first = t;
		else
			last->next = t;
		last = t;
		if((t->value = strdup(value))==NULL)
			goto err;
		if(type && *type){
			if((t->type = strdup(type))==NULL)
				goto err;
		} else {
			t->type = NULL;
		}
	}
	last->next = 0;
	setfields(oldfields);
	return (first);
err:
       if(first!=NULL)
               freeQtuple(first);
       spin_lock(&ipc_lock);
       errstr = "out of memory";
       spin_unlock(&ipc_lock);
       errno = ENOMEM;
       setfields(oldfields);
       return NULL;
}

freeQset(sp)
Qset *sp;
{
	register Qset *p;

	for(p = sp; p; ) {
		if(p->this)freeQtuple(p->this);
		sp = p->next;
		free((char *)p);
		p = sp;
	}
}

freeQtuple(t)
Qtuple *t;
{
	Qtuple *p;

	for(p = t; p;p = t ) {
		if(p->value) free(p->value);	
		if(p->type) free(p->type);
		t = p->next;
		free((char *)p);
	}
}
