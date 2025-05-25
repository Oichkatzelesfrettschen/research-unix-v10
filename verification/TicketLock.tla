---- MODULE TicketLock ----
EXTENDS Naturals

CONSTANT N

VARIABLES next, owner, pc, ticket

vars == <<next, owner, pc, ticket>>

Init == /\ next = 0
        /\ owner = 0
        /\ pc = [i \in 1..N |-> "idle"]
        /\ ticket = [i \in 1..N |-> 0]

Acquire(i) == /\ pc[i] = "idle"
               /\ pc' = [pc EXCEPT ![i] = "waiting"]
               /\ ticket' = [ticket EXCEPT ![i] = next]
               /\ next' = next + 1
               /\ UNCHANGED owner

Enter(i) == /\ pc[i] = "waiting"
             /\ ticket[i] = owner
             /\ pc' = [pc EXCEPT ![i] = "cs"]
             /\ UNCHANGED <<next, owner, ticket>>

Release(i) == /\ pc[i] = "cs"
               /\ pc' = [pc EXCEPT ![i] = "idle"]
               /\ owner' = owner + 1
               /\ UNCHANGED <<next, ticket>>

Next == \E i \in 1..N: Acquire(i) \/ Enter(i) \/ Release(i)

NoTwoCS == \A i, j \in 1..N: i /= j => ~(pc[i] = "cs" /\ pc[j] = "cs")

Spec == Init /\ [][Next]_vars

Inv == NoTwoCS
====
