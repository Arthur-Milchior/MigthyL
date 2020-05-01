(** A type allowing to get the parents of a formula, given its index.*)
type t;;

(** Given the formula, already indexed, get the object allowing quick access to parents*)
val precompute: Indexed.t -> t;;

(** Given an index, get all of its parents. I.e. in (p && (q || p)), it will return the formula ( q || p ) and the formula (p && (q || p )) *)
val getParentsFormula : Subformula.t -> t ->  Indexed.t list;;
(** Given an index, get the index of its parents. *)
val getParentsIndex : t ->  Indexed.t list;;
(** The list of pairs parent/child.*)
val parentChildrenList:  t  -> (Indexed.index * Indexed.index) list;;
