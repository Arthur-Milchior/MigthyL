open Utils;;

type index = int;;

(** Type of association list, from Nnf Formula to its index*)
type assoc = [Nnf.t, int];;

type nullary =
  | True
  | False
  | Prop of Atom.t
  | Prop_neg of Atom.t;;
(* type unary =
 *   | Next of Interval.t
 *   | DNext of Interval.t;; *)
type binary=
  | And
  | Or
  | Until of Interval.t
  | Release of Interval.t
  | BackTo of Interval.t
  | Since of Interval.t
;;

type t' =
  |Nullary of nullary
  |Binary of binary * t * t
and t =
  (t' * index)
;;

let fals = (Nullary False, -1);;
val format : Format.formatter -> t -> unit;;
(** Formatting as a basic formula. Each temporal operator, apart from
    the root, are replaced by their proposition. *)

val atomic_subformulas : t -> Atom.Set.t;;
val nb_distinct_subformula : t-> int;;
