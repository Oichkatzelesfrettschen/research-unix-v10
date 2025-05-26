---- MODULE Caps ----
EXTENDS Naturals, Sequences
(*  Model of capabilities with delegation and epoch revocation.*)
VARIABLES Caps,    \* Set of all capability records
         Parent,  \* Parent cap mapping: Parent[c] = parent cap id
         Epoch    \* Epoch mapping: Epoch[c] = current epoch of cap c

\* A capability is identified by a natural number
CapIds == 1..10
\* Rights are abstracted as a subset of {1,2,4,8}
Rights == {0, 1, 2, 4, 8}
\* Capability record mapping: each cap c has rights and type (ignored here)
CapRights[c \in CapIds] \in Rights

\* Initial state
Init ==
    /\ Caps = CapIds
    /\ Parent = [c \in Caps |-> 0]      \* 0 means no parent (root)
    /\ Epoch  = [c \in Caps |-> 0]

\* Action: refine a capability p into a new cap c
Refine(p, c, newRights) ==
    /\ p \in Caps
    /\ c \notin Caps
    /\ newRights \subseteq CapRights[p]
    /\ Caps' = Caps \cup {c}
    /\ Parent' = [Parent EXCEPT ![c] = p]
    /\ CapRights' = [CapRights EXCEPT ![c] = newRights]
    /\ Epoch' = [Epoch EXCEPT ![c] = Epoch[p]]
    /\ UNCHANGED <<Epoch[p], Caps, CapRights, Parent>>  \* except for c

\* Action: revoke a capability p (bump its epoch and propagate)
Revoke(p) ==
    /\ p \in Caps
    /\ LET
         Rec(parent) ==
             { c \in Caps : Parent[c] = parent }
       IN
       /\ Epoch' = [c \in Caps |->
             IF c = p \/ c \in Rec(p) \/ c \in RecSubset(p) THEN Epoch[c] + 1 ELSE Epoch[c]]
       /\ UNCHANGED <<Caps, CapRights, Parent>>

\* Recursively collect all descendants
RecSubset(p) ==
    RECURSIVE Desc(_)
    Desc(x) == { c \in Caps : Parent[c] = x } \cup UNION { Desc(c) : c \in Caps /\ Parent[c]=x }
    IN Desc(p)

\* Invariant: Every child cap's epoch equals its parent's epoch
InvEpoch ==
    \A c \in Caps:
      Parent[c] # 0 => Epoch[c] = Epoch[ Parent[c] ]

Spec == Init /\ [][Refine(_,_,_) \/ Revoke(_)]_<<Caps,Parent,CapRights,Epoch>>

THEOREM Spec => []InvEpoch
====
