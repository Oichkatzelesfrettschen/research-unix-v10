/*ident	"@(#)ctrans:src/print.c	1.6" */
/**************************************************************************

	C++ source for cfront, the C++ compiler front-end
	written in the computer science research center of Bell Labs

	Copyright (c) 1984 AT&T, Inc. All rights Reserved
	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF AT&T, INC.

print.c:

	print statements and expressions

****************************************************************************/

#include "cfront.h"

static int addrof_cm ;
extern void puttok(TOK);

#define eprint(e) if (e) Eprint(e)

void Eprint(Pexpr e)
{
	switch (e->base) {
	case REF:
		if (Pref(e)->mem && Pref(e)->mem->tp && Pref(e)->mem->tp->base == FCT) {
			//  suppress ``this'' in ``this->f''
			Pref(e)->mem->print();
			break;
		}
	case NAME:
	case MDOT:
	case ID:
	case ZERO:
	case ICON:
	case CCON:
	case FCON:
	case STRING:
	case IVAL:
	case TEXT:
	case CM:
	case G_CM:
	case ELIST:
	case COLON:
	case ILIST:
	case DOT:
	case THIS:
	case CALL:
	case G_CALL:
	case ICALL:
	case ANAME:
		e->print();
	case DUMMY:
		break;
	default:
		putch('(');
		e->print();
		putch(')');
	}
}

void expr::print()
{
	if (this == 0) error('i',"0->E::print()");
	if (this==e1 || this==e2) error('i',"(%p%k)->E::print(%p %p)",this,base,e1,e2);
// error('d',"(%d %k)->expr::print(%d %d)",this,base,e1,e2);

	switch (base) {
	case MDOT:
	{
// error('d',"mdot %s i1 %d %t",string2,i1,mem->tp);
	int not_allocated = 0;
		switch (i1) {
		case 0:
			putcat('O',string2);
			puttok(DOT);	// use sub-object directly
			mem->print();
			break;
		case 1:
			putcat('P',string2);
			puttok(REF);	// use through pointer
			mem->print();
			break;
		case 2:
			if (mem->tp->is_ptr_or_ref()==0) {
				mem->print();
				puttok(DOT);
				putcat('O',string2);
			}
			else
			{
			putch('(');	// REF turns pointer into object: add &
			putch('&');	// ``this'' is a pointer
			putch('(');
			eprint(mem);
			puttok(REF);	// call sub-object directly
			putcat('O',string2);
			putch(')');
			putch(')');
			}
			break;
		case 5:
			not_allocated = 1;
			// no break;	
		case 3:
		    if (mem->tp->is_ptr_or_ref()==0) {
			putch('(');	// Px is a pointer (T*) turn it back to a T
			putch('*');	// *Px
			putch('(');
			eprint(mem);//mem->print();
			puttok(DOT);	//  call through pointer
			putcat('P',string2);
			putch(')');
			putch(')');
		    }
		    else {
			if (not_allocated) {
				putch('(');
				mem->print();
				if ( mem->base == NAME ) 
					puttok(REF);
				else puttok(DOT);
				putcat('O',string4);
				putch(')');
			}
			else eprint(mem);
			if (mem->base == NAME && not_allocated)
				puttok(DOT);
			else puttok(REF);	//  call through pointer
			putcat('P',string2);
		    }
		    break;
		case 9:	// vtbl entry:	(p->_vtbl).f, (p->_vtbl).i, (p->_vtbl).d
			// or memptr: mp.f, mp.i, mp.d
			eprint(mem);
			putch('.');
			putstring(string2);
		} // end switch(i1)
		break;
	} // end MDOT

	case NAME:
	{	Pname n = Pname(this);
                if (n->n_evaluated
                && n->n_scope!=ARG) {
                        Ptype t = tp->skiptypedefs();
                        if (t->base == EOBJ) t = Penum(Pbase(t)->b_name->tp)->e_type;
                        if (t->base!=INT || t->is_unsigned()) {
				putstring("((");
				bit oc = Cast;
				Cast = 1;
                                t->print();
				Cast = oc;
				fprintf(out_file,")%d)",n->n_val);
			}
			else
				fprintf(out_file,"%d",n->n_val);
		}
		else
			n->print();
		break;
	}
	case ANAME:
		if (curr_icall) {	// in expansion: look it up
			Pname n = Pname(this);
			int argno = int(n->n_val);

			for (Pin il=curr_icall; il; il=il->i_next)
				if (n->n_table == il->i_table) goto aok;
			goto bok;
		aok:
			if (n = il->i_args[argno].local) {
				n->print();
			}
			else {
				Pexpr ee = il->i_args[argno].arg;
				Ptype t = il->i_args[argno].tp;
				if (ee==0 || ee==this) error('i',"%p->E::print(A %p)",this,ee);
				if (ee->tp==0
				|| (t!=ee->tp && t->check(ee->tp,0) && t->is_cl_obj()==0)
				) {
					putstring("((");
					bit oc = Cast;
					Cast = 1;
					t->print();
					Cast = oc;
					putch(')');
					eprint(ee);
					putch(')');
				}
				else
					eprint(ee);
			}
		}
		else {
		bok:	/* in body: print it: */
			Pname(this)->print();
		}
		break;

	case ICALL:
	{	il->i_next = curr_icall;
		curr_icall = il;
//error('d',"icall %n",il->fct_name);
		if (il == 0) error('i',"E::print: iline missing");
		Pexpr a0 = il->i_args[0].arg;
		int val = QUEST;
		if (il->fct_name->n_oper != CTOR) goto dumb;

		/*
			find the value of "this"
	   		if the argument is a "this" NOT assigned to
			by the programmer, it was initialized
		*/
		switch (a0->base) {
		case ZERO:
			val = 0;
			break;
		case ADDROF:
		case G_ADDROF:
			val = 1;
			break;
		case CAST:
			if (a0->e1->base == ANAME || a0->e1->base == NAME) {
				Pname a = (Pname)a0->e1;
				if (a->n_assigned_to == FUDGE111) val = FUDGE111;
			}
		}
		if (val==QUEST) goto dumb;
		/*
			now find the test:  "(this==0) ? _new(sizeof(X)) : 0"

			e1 is a comma expression,
			the test is either the first sub-expression
				or the first sub-expression after the assignments
					initializing temporary variables
		 */
	dumb:
		eprint(e1);
		if (e2) Pstmt(e2)->print();
		curr_icall = il->i_next;
		break;
	}
	case REF:
	case DOT:
		eprint(e1);
		puttok(base);
		if (mem == 0) {
			fprintf(out_file,"MEM0");
			break;
		}
		if (mem->base == NAME)
			Pname(mem)->print();
		else
			mem->print();
		break;

	case MEMPTR:
		error("P toMF not called");
		break;

	case VALUE:
		tp2->print();
		puttok(LP);
		if (e1) e1->print();
		puttok(RP);
		break;

	case SIZEOF:
		puttok(SIZEOF);
		if (e1 && e1!=dummy) {
			eprint(e1);
		}
		else if (tp2) {
			putch('(');
			if (tp2->base == CLASS) {
				Pclass cl = Pclass(tp2);
				putstring((cl->csu == UNION)?"union ":"struct ");
				char *str = 0;
    				// nested local class does not encode name
    				if ( cl->lex_level && cl->nested_sig == 0 ) 
    					str = make_local_name( cl );
    				putstring(str?str:(cl->nested_sig?cl->nested_sig:cl->string));
				delete str;
			}
			else
				tp2->print();
			putch(')');
		}
		break;

	case CAST:
		putch('(');
//error('d',"print cast %t",tp2);
		if (tp2->base != VOID && tp2->memptr() == 0 ) {
                        // when VOID is represented as CHAR not everything
                        // can be cast to VOID
			putch('(');
			bit oc = Cast;
			Cast = 1;
			tp2->print();
			Cast = oc;
			putch(')');	
		}
		eprint(e1);
		putch(')');
		break;

	case ICON:
	case FCON:
	case CCON:
	case ID:
		if (string) putst(string);
		break;

	case STRING:
                // avoid printing very long lines
                ntok += 4;
		fprintf(out_file,"\"%s\"",string);
		break;

	case THIS:
	case ZERO:
		putstring("0 ");
		break;

	case IVAL:
		fprintf(out_file,"%d",i1);
		break;

	case TEXT:
	{
		int oo = vtbl_opt;	// make `simulated static' name
		vtbl_opt = -1;	
		char* s = vtbl_name(string,string2);
		vtbl_opt = oo;
		s[2] = 'p';	// pointer, not tbl itself
                char* t = ptbl_lookup(s);
                fprintf(out_file, " %s",t);
		delete t;

		char *str = 0;
		if ( string ) { 
			str = new char[ strlen(string) + strlen(string2) + 1 ];
			strcpy( str, string );
			strcat( str, string2 );
		}

		if ( ptbl->look( str?str:string2, 0 ) == 0 &&
		     ptbl->look( str?str:string2, HIDDEN ) == 0 ) {
			Pname nn = ptbl->insert(new name(str?str:string2),0);
			nn->string2 = new char[strlen(s)+1];
			strcpy(nn->string2,s);
		}

		delete str;
		delete s;
	}
		// no break;

	case DUMMY:
		break;

	case G_CALL:
	case CALL:
	{	Pname fn = fct_name;
		Pname at;
		int m_ptr = 0;

		if (fn) {
			Pfct f = Pfct(fn->tp);

			if (f->base==OVERLOAD) {	// overloaded after call
				fct_name = fn = Pgen(f)->fct_list->f;
				f = Pfct(fn->tp);
			}

			fn->print();
			at = f->f_args;
		}
		else {
			Pfct f = Pfct(e1->tp);

			if (f) {	// pointer to fct
				Pexpr exex = e1;
				if ( exex->base == DEREF ) {
    					exex = exex->e1;
    					while ( exex->base == CAST )
       						exex = exex->e1;
    					if ( exex->base == MDOT )
       						m_ptr = 1;
				}

				if (f->base == OVERLOAD) { // overloaded after call
					fct_name = fn = Pgen(f)->fct_list->f;
					f = Pfct(fn->tp);
				}

				f = Pfct(f->skiptypedefs());
				if (f->base == PTR) {
					putstring("(*");
					e1->print();
					putch(')');
					f = Pfct(Pptr(f)->typ->skiptypedefs());
				}
				else
					eprint(e1);

				at = f->f_args;
			}
			else {	// virtual: argtype encoded
				// f_this already linked to f_result and/or argtype
				at = (e1->base==QUEST) ? Pname(e1->e1->tp2) : Pname(e1->tp2);
				eprint(e1);
			}
		}

		puttok(LP);

		if (e2) {
			if (at) {
				Pexpr e = e2;
				while (at) {
					Pexpr ex;
					Ptype t = at->tp;

					if (t == 0) error('i',"T ofA missing for%n",fn);
					if (e == 0) error('i',"%tA missing for%n",t,fn);
					if (e->base == ELIST) {
						ex = e->e1;
						e =  e->e2;
					}
					else
						ex = e;

					if (ex == 0) error('i',"A ofT%t missing",t);
					if (t!=ex->tp
					&& ex->tp
					&& t->check(ex->tp,0)
					&& t->is_cl_obj()==0
					&& eobj==0
					&& m_ptr == 0
					&& (t->is_ptr()==0 || Mptr==0)) {
						putch('(');
						bit oc = Cast;
						Cast = 1;
						t->print();
						Cast = oc;
						putch(')');
#ifdef sun
if (ex->base == DIV) { // defend against perverse SUN cc bug
	putstring("(0+");
	eprint(ex);
	putch(')');
}
else
#endif
						eprint(ex);
					}
					else
						ex->print();

					// if m_ptr is set, then don't advance at
					// at does not know about generated `this'
					if ( m_ptr ) {
						m_ptr = 0;
						if (at) puttok(CM);
						continue;
					}

					at = at->n_list;
					if (at) puttok(CM);
				}
				if (e) {
					puttok(CM);
					e->print();
				}		 
			}
			else
				e2->print();
		}
		puttok(RP);
		break;
	}

	case ASSIGN:
		if (e1->base==ANAME && Pname(e1)->n_assigned_to==FUDGE111) {
		// suppress assignment to "this" that has been optimized away
			Pname n = Pname(e1);
			int argno = int(n->n_val);
			for (Pin il=curr_icall; il; il=il->i_next)
				if (il->i_table == n->n_table) goto akk;
			goto bkk;
		akk:
			if (il->i_args[argno].local == 0) {
				e2->print();
				break;
			}
		}
		//no break
	case EQ:
	case NE:
	case GT:
	case GE:
	case LE:
	case LT:
	bkk:
	{
		Ptype t2 = e2->tp;

		eprint(e1);
		puttok(base);

		if (e1->tp && e1->tp!=e2->tp && e2->base!=ZERO) {
			// cast, but beware of int!=long etc.
			Ptype t1 = e1->tp->skiptypedefs();
			switch (t1->base) {
			default:
                                break;
			case PTR:
			case RPTR:
			case VEC:
			{ Ptype t2 = e2->tp->skiptypedefs();

				if (e2->tp==0
				|| (Pptr(t1)->typ!=Pptr(t2)->typ && t1->check(t2,0))) {
					putch('(');
					bit oc = Cast;
					Cast = 1;
					e1->tp->print();
					Cast = oc;
					putch(')');	
				}
			}
			}
		}

		eprint(e2);
		break;
	}

	case DEREF:
		if (e2) {

			eprint(e1);
			putch('[');
			eprint(e2);
			putch(']');
		}
		else {
                        putch('(');
			putch('*');
			eprint(e1);
                        putch(')');
		}
		break;

	case ILIST:
		puttok(LC);
		if (e1) e1->print();
		if (e2) {	// member pointer initiliazers
			puttok(CM);
			e2->print();
		}
		puttok(RC);
		break;

	case ELIST:
	{	Pexpr e = this;
		for(;;) {
			if (e->base == ELIST) {
				e->e1->print();
				if (e = e->e2) {
					puttok(CM);
				}
				else
					return;
			}
			else {
				e->print();
				return;
			}
		}
	}

	case QUEST:
	{	// look for (&a == 0) etc.
		Neval = 0;
		binary_val = 1;
		long i = cond->eval();
		binary_val = 0;
		if (Neval == 0)
			(i?e1:e2)->print();
		else {
			eprint(cond);
			putch('?');
                	eprint(e1);
			putch(':');
                	eprint(e2);
		}
		break;
	}

	case CM:	// do &(a,b) => (a,&b) for previously checked inlines
	case G_CM:
		puttok(LP);
		switch (e1->base) {
		case ZERO:
		case IVAL:
		case ICON:
		case NAME:
		case MDOT:
		case DOT:
		case REF:
		case FCON:
		case STRING:
			goto le2;	// suppress constant a: &(a,b) => (&b)
		default:
			{	int oo = addrof_cm;	// &(a,b) does not affect a
				addrof_cm = 0;
				eprint(e1);
				addrof_cm = oo;
			}
			puttok(CM);
		le2:
			if (addrof_cm) {
				switch (e2->base) {
				case CAST:
					if (e2->e2)
					switch (e2->e2->base) {
					case CM:
					case G_CM:
					case ICALL:	goto ec;
					}
				case NAME:
				case MDOT:
				case DOT:
				case DEREF:
				case REF:
				case ANAME:
					puttok(ADDROF);
					addrof_cm--;
					eprint(e2);
					addrof_cm++;
					break;
				case ICALL:
				case CM:
				case G_CM:
				ec:
					eprint(e2);
					break;
				case G_CALL:
					/* & ( e, ctor() ) with temporary optimized away */
					if (e2->fct_name
					&& e2->fct_name->n_oper==CTOR) {
						addrof_cm--;
						eprint(e2);
						addrof_cm++;
						break;
					}
				default:
					error('i',"& inlineF call (%k)",e2->base);
				}
			}
			else
				eprint(e2);
			puttok(RP);
		}
		break;

	case ADDROF:
	case G_ADDROF:
		switch (e2->base) {	// & *e1 or &e1[e2]
		case DEREF:
			if (e2->e2 == 0) {	// &*e == e
				e2->e1->print();
				return;
			}
			break;
		case ICALL:
			addrof_cm++;	// assumes inline expanded into ,-expression
			eprint(e2);
			addrof_cm--;
			return;
		case ASSIGN:		// &(a=b)	??? works on many cc s
			eprint(e2);	// make sure it breaks!
			return;
		case NAME: {
			Pname n = Pname(e2);
			if(n->n_evaluated) {
				n->n_evaluated=0;
				puttok(ADDROF);
				eprint(e2);
				n->n_evaluated=1;
				return;
			}
			break;
			}
		}

		// suppress cc warning on &fct
		if (e2->tp==0 || e2->tp->base!=FCT) puttok(ADDROF);

		eprint(e2);
		break;

	case PLUS:
	case MINUS:
	case MUL:
	case DIV:
	case MOD:
	case LS:
	case RS:
	case AND:
	case OR:
	case ER:
	case ANDAND:
	case OROR:
        case DECR:
        case INCR:
	case ASOR:
	case ASER:
	case ASAND:
	case ASPLUS:
	case ASMINUS:
	case ASMUL:
	case ASMOD:
	case ASDIV:
	case ASLS:
	case ASRS:
                eprint(e1);
		// no break
	case UPLUS: // only preserved for ansi_opt==1
	case UMINUS:
	case NOT:
	case COMPL:
		puttok(base);
		eprint(e2);
                break;

	default:
		error('i',"%p->E::print%k",this,base);
	}
}

Pexpr aval(Pname a)
{
	int argno = int(a->n_val);
	Pin il;
	for (il=curr_icall; il; il=il->i_next)
		if (il->i_table == a->n_table) goto aok;
	return 0;
aok:
	Pexpr aa = il->i_args[argno].arg;
ll:
	switch (aa->base) {
	case CAST:	aa = aa->e1; goto ll;
	case ANAME:	return aval(Pname(aa));
	default:	return aa;
	}
}

#define putcond()	putch('('); e->print(); putch(')')

static loc csloc = { 0, 0 }; // loc of last stmt with line!=0

void stmt::print()
{
//error('d',"S::print %d:%k s %d s_list %d",this,base,s,s_list);
	if (where.line == 0) {
	    if (csloc.line) csloc.putline();
	} else {
	    csloc = where;
	    if (where.line!=last_line.line)
		if (last_ll = where.line)
			where.putline();
		else
			last_line.putline();
	}

	if (memtbl && base!=BLOCK) { /* also print declarations of temporaries */
		puttok(LC);
		Ptable tbl = memtbl;
		memtbl = 0;
		int i;
		int bl = 1;
		for (Pname n=tbl->get_mem(i=1); n; n=tbl->get_mem(++i)){
			if (n->tp == any_type) continue;
			/* avoid double declarartion of temporaries from inlines */
			char* s = n->string;
			if (s[0]!='_' || s[1]!='_' || s[2]!='X') {
				n->dcl_print(0);
				bl = 0;
			}
			Pname cn;
			if (bl
			&& (cn=n->tp->is_cl_obj())
			&& Pclass(cn->tp)->has_dtor()) bl = 0;
		}
		if ( last_ll==0 && (last_ll = where.line) )
			where.putline();
		if (bl) {
			Pstmt sl = s_list;
			s_list = 0;
			print();
			memtbl = tbl;
			puttok(RC);
			if (sl) {
				s_list = sl;
				sl->print();
			}
		}
		else {
			print();
			memtbl = tbl;
			puttok(RC);
		}
		return;
	}

	switch (base) {
	default:
		error('i',"S::print(base=%k)",base);

	case ASM:
		fprintf(out_file,"asm(\"%s\");\n",(char*)e);
		break;

	case DCL:
		d->dcl_print(SM);
		break;

	case BREAK:
	case CONTINUE:
		puttok(base);
		puttok(SM);
		break;

	case DEFAULT:
		puttok(base);
		putch(':');
		s->print();
		break;

	case SM:
		if (e) {
			e->print();
			if (e->base==ICALL && e->e2) break;	/* a block: no SM */
		}
		puttok(SM);
		break;

	case WHILE:
		puttok(WHILE);
		putcond();
		if (s->s_list) {
			puttok(LC);
			s->print();
			puttok(RC);
		}
		else
			s->print();
		break;

	case DO:
		puttok(DO);
		s->print();
		puttok(WHILE);
		putcond();
		puttok(SM);
		break;

	case SWITCH:
		puttok(SWITCH);
		putcond();
		s->print();
		break;

	case RETURN:
		{
		puttok(RETURN);
		if (e) {
//error('d',"print return rt %t etp %t",ret_tp,e->tp);
			if (ret_tp && ret_tp!=e->tp) {
				Ptype tt = ret_tp->skiptypedefs();
			
				switch (tt->base) {
				case COBJ:
					break;	// cannot cast to struct
				case RPTR:
				case PTR:
					if (Pptr(tt)->typ==Pptr(e->tp)->typ) break;
					if (Pptr(tt)->memof) break;
				default:
					if (e->tp==0 || ret_tp->check(e->tp,0)) {
						int oc = Cast;
						putch('(');
						Cast = 1;
						ret_tp->print();
						Cast = oc;
						putch(')');
					}
				}
			}
			eprint(e);
		}
		puttok(SM);
		}
		while (s_list && s_list->base==SM) s_list = s_list->s_list; // FUDGE!!
		break;

	case CASE:
		puttok(CASE);
		eprint(e);
		putch(':');
		s->print();
		break;

	case GOTO:
		puttok(GOTO);
		d->print();
		puttok(SM);
		break;

	case LABEL:
		d->print();
		putch(':');
		s->print();
		break;

	case IF:
	{	int val = QUEST;
		if (e->base == ANAME) {
			Pname a = Pname(e);
			Pexpr arg = aval(a);
//error('d',"arg %d%k %d (%d)",arg,arg?arg->base:0,arg?arg->base:0,arg?arg->e1:0);
			if (arg)
				switch (arg->base) {
				case ZERO:	val = 0; break;
				case ADDROF:
				case G_ADDROF:	val = 1; break;
				case IVAL:	val = arg->i1!=0;
			}
		}
//error('d',"val %d",val);
		switch (val) {
		case 1:
			s->print();
			break;
		case 0:
			if (else_stmt)
				else_stmt->print();
			else
				puttok(SM);	/* null statement */
			break;
		default:
			puttok(IF);
			putcond();
			if (s->s_list) {
				puttok(LC);
				s->print();
				puttok(RC);
			}
			else
				s->print();
			if (else_stmt) {
				if (else_stmt->where.line == 0) {
				    if (csloc.line) csloc.putline();
				} else {
				    csloc = else_stmt->where;
				    if (else_stmt->where.line!=last_line.line)
					if (last_ll = else_stmt->where.line)
						else_stmt->where.putline();
					else
						last_line.putline();
				}
				puttok(ELSE);
				if (else_stmt->s_list) {
					puttok(LC);
					else_stmt->print();
					puttok(RC);
				}
				else
					else_stmt->print();
			}
		}
		break;
	}

	case FOR:
	{
		int fi = 0;	// is the initializer statement an expression?
		if (for_init) {
			fi = 1;
			if (for_init->memtbl==0 && for_init->s_list==0)
				if (for_init->base==SM)
					if (for_init->e->base!=ICALL || for_init->e->e1)
						fi = 0;
		}
//error('d',"for(; %d%k; %d%k)",e,e->base,e2,e2->base);
		if (fi) {
			puttok(LC);
			for_init->print();
		}
		putstring("for(");
		if (fi==0 && for_init) for_init->e->print();
		putch(';');	// to avoid newline: not puttok(SM)
		if (e) e->print();
		putch(';');
		if (e2) e2->print();
		puttok(RP);
		s->print();
		if (fi) puttok(RC);
		break;
	}

	case PAIR:
		if (s&&s2) {
			puttok(LC);
			s->print();
			s2->print();
			puttok(RC);
		}
		else {
			if (s) s->print();
			if (s2) s2->print();
		}
		break;

	case BLOCK:
		puttok(LC);
//error('d',"block %d d %d memtbl %d own_tbl %d",this,d,memtbl,own_tbl);
		if (d) d->dcl_print(SM);
		if (memtbl && own_tbl) {
			Pname n;
			int i;
			for (n=memtbl->get_mem(i=1); n; n=memtbl->get_mem(++i)) {
				if (n->tp && n->n_union==0 && n->tp!=any_type)
					switch (n->n_scope) {
					case ARGT:
					case ARG:
						break;
					default:
// error('d', "n: %s %k n_key: %k", n->string, n->base, n->n_key);
						if ( n->base == TNAME && n->n_key == NESTED ) 
							continue; // printed from nested class
						n->dcl_print(0);
					}
			}
			if (last_ll==0 && s && (last_ll=s->where.line))
				s->where.putline();
		}
		if (s) s->print();
		if (where2.line == 0) {
		    if (csloc.line) csloc.putline();
		} else {
		    csloc = where2;
		    if (where2.line!=last_line.line)
			if (last_ll = where2.line)
				where2.putline();
			else
				last_line.putline();
		}
		putstring("}\n");
		if (last_ll && where.line) last_line.line++;
	}

	if (s_list) s_list->print();
}

/*
void table::dcl_print(TOK s, TOK pub)

//	print the declarations of the entries in the order they were inserted
//	ignore labels (tp==0)

{
	register Pname* np;
	register int i;

	if (this == 0) return;

	np = entries;
	for (i=1; i<free_slot; i++) {
		register Pname n = np[i];
		switch (s) {
		case 0:
			n->dcl_print(0);
			break;
		case EQ:
			if (n->tp && n->n_scope == pub) n->dcl_print(0);
			break;
		case NE:
			if (n->tp && n->n_scope != pub) n->dcl_print(0);
			break;
		}
	}
}
*/

struct ptbl_rec {
      char* pname;
      char* vname;
      ptbl_rec* next;
};

static char* ptbl_name;
static ptbl_rec* ptbl_rec_lookup_head = 0;
static ptbl_rec* ptbl_rec_pair_head = 0;

void ptbl_init(int flag)
{
      if (!flag) {
	      char *p = st_name( "__ptbl_vec__" );	
              ptbl_name = new char[strlen(p)+1];
              strcpy(ptbl_name, p);                         
              delete p;
              fprintf(out_file, "extern struct __mptr* %s[];\n", ptbl_name);
		if (last_ll) last_line.line++;
      }
      else {
              ptbl_rec *r, *p = ptbl_rec_lookup_head;
	      if ( p == 0 ) return; // don't generate an empty object
              fprintf(out_file, "struct __mptr* %s[] = {\n", ptbl_name);
		if (last_ll) last_line.line++;
              int i = 0;
              while (p != 0) {
                      r = ptbl_rec_pair_head;
                      while (r && strcmp(r->pname, p->pname))
                              r = r->next;
                      fprintf(out_file, "%s,\n", r->vname);
			if (last_ll) last_line.line++;
                      p = p->next;
              }
              fprintf(out_file, "\n};\n");
		if (last_ll) last_line.line += 2;
      }
}

char* ptbl_lookup(char *name)
{
      ptbl_rec *r, *s, *p = ptbl_rec_lookup_head;
      int i = 0;

      while (p && strcmp(name, p->pname)) {
              r = p;
              p = p->next;
              i++;
      }

      if (p == 0) {
              s = new ptbl_rec;
              s->pname = new char[strlen(name) + 1];
              s->vname = 0;
              s->next = 0;
              strcpy(s->pname, name);
              if (ptbl_rec_lookup_head == 0) 
                      ptbl_rec_lookup_head = s;
              else r->next = s;
      }

      char *pp = new char[ strlen(ptbl_name) + 10 ];  	
      sprintf(pp, "%s[%d]", ptbl_name, i);
      return(pp);
}

void ptbl_add_pair(char* ptbl, char* vtbl)
{
// error('d', "ptbl_add_pair: ptbl: %s, vtbl: %s", ptbl, vtbl );
      ptbl_rec *p = new ptbl_rec;

      p->pname = new char[strlen(ptbl) + 1];
      strcpy(p->pname, ptbl);
      p->vname = new char[strlen(vtbl) + 1];

      strcpy(p->vname, vtbl);
      p->next = ptbl_rec_pair_head;

      ptbl_rec_pair_head = p;
}
