(** * Migration functor from C89 to C23 terms *)
Require Import ../Core/LambdaCalc.

Module FunctorF.
Import LambdaCalc.

Definition F_obj (t : term) : term := t.

Lemma F_preserve_beta : forall t u,
  beta t u -> beta (F_obj t) (F_obj u).
Proof. intros; assumption. Qed.

End FunctorF.
