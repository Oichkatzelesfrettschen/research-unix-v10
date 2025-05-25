(** * Sketch of \nu-calculus for scheduling *)

Module NuCalc.

Inductive formula : Type :=
| FBox : formula -> formula
| FNu : nat -> formula -> formula.

End NuCalc.
