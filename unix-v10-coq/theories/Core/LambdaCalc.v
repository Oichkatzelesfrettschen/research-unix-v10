(** * Minimal Lambda Calculus for Unix v10 proofs *)

Module LambdaCalc.

Inductive term : Type :=
| Var : nat -> term
| App : term -> term -> term
| Abs : nat -> term -> term.

Reserved Notation "t1 ->beta t2" (at level 40).

Inductive beta : term -> term -> Prop :=
| beta_step x t u : beta (App (Abs x t) u) (subst x u t)
| app_l t1 t1' t2 : beta t1 t1' -> beta (App t1 t2) (App t1' t2)
| app_r t1 t2 t2' : beta t2 t2' -> beta (App t1 t2) (App t1 t2')
| abs_beta x t t' : beta t t' -> beta (Abs x t) (Abs x t')
where "t1 ->beta t2" := (beta t1 t2).

(* substitution *)
Fixpoint subst (x:nat) (s:term) (t:term) : term :=
  match t with
  | Var y => if Nat.eqb x y then s else t
  | App t1 t2 => App (subst x s t1) (subst x s t2)
  | Abs y t1 => if Nat.eqb x y then t else Abs y (subst x s t1)
  end.

End LambdaCalc.
