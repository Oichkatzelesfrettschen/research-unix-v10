(** * Preservation sketch for Unix v10 migration *)
Require Import ../Core/LambdaCalc.
Require Import ../Migration/FunctorF.

Lemma lambda_preservation : forall t u,
  LambdaCalc.beta t u <-> LambdaCalc.beta (FunctorF.F_obj t) (FunctorF.F_obj u).
Proof.
  split; intros H; now apply FunctorF.F_preserve_beta.
Qed.
