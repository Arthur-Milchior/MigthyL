(** Fundamentally, it's the identity function. Except that it adds
   index to ensure unicity of formulas.

It is guaranteed that:
* the input formula has index 0, and 
* the subformulas of formula i only has indexes greater than i.
 *)
val tranform :
  Nnf.t -> (Indexed.t, Indexed.assoc)
;;
