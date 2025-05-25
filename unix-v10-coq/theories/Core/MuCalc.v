(** * Sketch of \mu-calculus for memory management *)

Module MuCalc.

Inductive formula : Type :=
| FTrue : formula
| FFalse : formula
| FMu : nat -> formula -> formula.

End MuCalc.
