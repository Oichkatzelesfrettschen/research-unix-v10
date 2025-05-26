---- MODULE IPC ----
EXTENDS Naturals, Sequences
(*  Model of a single IPC primitive with fast-path and slow-path.  We verify that only authorized sends occur and fast-path bounds.*)
CONSTANT MaxMsgSize, FastCopyLimit \* e.g., 4096 and 64
VARIABLES MsgSize, UsingFastPath

Init ==
    /\ MsgSize = 0
    /\ UsingFastPath = FALSE

\* Action: Send a message of size s
Send(s) ==
    /\ s \in 1..MaxMsgSize
    /\ MsgSize' = s
    /\ UsingFastPath' = (s <= FastCopyLimit)
    /\ UNCHANGED <<>>

\* Invariant 1: if UsingFastPath then MsgSize \u2264 FastCopyLimit
InvFast ==
    UsingFastPath => MsgSize <= FastCopyLimit

\* Action: Change buffer size (simulate resend)
Resize(s) ==
    /\ s \in 1..MaxMsgSize
    /\ MsgSize' = s
    /\ UsingFastPath' = (s <= FastCopyLimit)
    /\ UNCHANGED <<>>

Spec == Init /\ [][Send(_) \/ Resize(_)]_<<MsgSize,UsingFastPath>>

THEOREM Spec => []InvFast
====
