(** * Simple \pi-calculus for IPC *)

Module PiCalc.

Definition chan := nat.

Inductive proc : Type :=
| Zero : proc
| Send : chan -> nat -> proc -> proc
| Recv : chan -> nat -> proc -> proc
| Par : proc -> proc -> proc.

Reserved Notation "P ->pi Q" (at level 40).

Inductive step : proc -> proc -> Prop :=
| step_comm c v P Q :
    step (Par (Send c v P) (Recv c v Q)) (Par P Q)
| step_par_l P P' Q : step P P' -> step (Par P Q) (Par P' Q)
| step_par_r P Q Q' : step Q Q' -> step (Par P Q) (Par P Q')
where "P ->pi Q" := (step P Q).

End PiCalc.
