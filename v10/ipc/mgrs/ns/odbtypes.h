#define MAXPAIRS 128		/* maximum attributes per tuple */
#define MAXDISTANCE 10		/* maximum distance between tuples */
#define MAXPATH 256		/* maximum size of a path */
#define MAXLINE 4096		/* longest possible line */

/*
 *  predeclared for circular definitions
 */
class Attribute;
class Tuple;
class Set;

/*
 *  externally defined routines
 */
extern int dom_distance(char *, char *);
extern int dk_distance(char *, char *);
extern "C" setfields(char *);
extern "C" getmfields(char *, char **, int);

/*
 *  a faster strcmp
 */
inline int
fstrcmp(char *a, char *b)
{
	if(*a==*b)
		return strcmp(a, b);
	else
		return *a - *b;
}

/*
 *  An ordered list.  This implimentation uses skip lists by Pugh.
 */
class Ordered {
	char level;		/* level of the skip lists 0 == leaves */
	Ordered **ptr;		/* skip pointers */
public:
	Ordered(){ ptr = 0; }
	Ordered(int);
	~Ordered();
	void insert(Ordered *);
	Ordered *search(Ordered *);
	virtual int compare(Ordered *);
	virtual void print(int);
	void printlist(int);
	Ordered *succ() { return ptr[0]; };
};

/*
 *  A typed attribute.  The string form is `value,type'.
 */
class Attribute : public Ordered {
	char *value;
	char *type;
	int wild;
	Tuple *tuple;			/* tuple this attr belongs to */

	friend Set *lookup(char *, Ordered *);
public:
	Attribute *next;		/* visible for Tuple */

	Attribute(){ value = type = 0; next = 0; }
	Attribute(char *, Tuple *, char);
	~Attribute();
	int compare(Ordered *);
	int compatible(Ordered *);
	int distance(Attribute *);
	int simpleprint(int);
	void print(int);
	int iskey();
	int printvalue(int, char *);
};

/*
 *  A list of attributed strings.  The linear form is
 *  `attribute attribute ...\n'.
 */
class Tuple {
	Attribute *first;
	Attribute *last;
	int dist;
	Tuple *tail;		/* pointer to catenated tuple */
	Tuple *anext;		/* allocation chain */

	friend void freetuplelist(Tuple **);
	friend Set *lookup(char *, Ordered *);
	friend int comparetuples(Tuple **, Tuple **);
public:
	Tuple *next;		/* Set chain */

	Tuple() { first = last = 0; tail = anext = next = 0; }
	Tuple(char *, Ordered *, Tuple **, char);
	Tuple(char *x, Ordered *y, Tuple **z) { this = new Tuple(x, y, z, 0); }
	Tuple(char *x, Tuple **z) { this = new Tuple(x, (Ordered *)0, z, 0); }
	Tuple(char *x, char w){ this = new Tuple(x, (Ordered *)0, (Tuple **)0, w);}
	~Tuple();
	match(Tuple *);
	void distance(Tuple *);
	int print(int);
	void cat(Tuple *);
	int printvalue(int, char *);
};

/*
 *  A list of tuples.  The linear form is
 *  `tuple\ntuple\n...'.
 */
class Set {
public:
	Tuple *first;
	Tuple *last;
	int tuples;

	Set(){ first = last = 0; tuples = 0; };
	Set(int);
	void add(Tuple *);
	void sort(Tuple *);
	int print(int);
	void printvalue(int, char **);
};

extern "C" int logevent(...);
extern "C" int logconsole(...);
