(** Fundamentally, it's the identity function. Except that it adds
   index to ensure unicity of formulas. *)
val tranform : Nnf.t -> Indexed.t;;
