(** Some object allowing to acces to a formula given its index.*)
type t;;
val precompute : Indexed.t -> t;;
(** List of all subformulas *)
val subformulas: t -> Indexed.t list;;
(** Given an index, get the subformula *)
val indexToSubformula : t -> Indexed.index -> Indexed.t;;
