(** The atomic formulas *)
type nullary =
  | True
  | False
  | Prop of Atom.t;;

(** The unary operators *)
type unary =
  | Not
;;

(** The binary operators *)
type binary=
  | And
  | Or
  | Until of Interval.t
  | Release of Interval.t
  | BackTo of Interval.t
  | Since of Interval.t
;;

(** the type of formula as in the input *)
type t=
  |Nullary of nullary
  |Unary of (unary * t)
  |Binary of (binary * t * t);;
val format : Format.formatter -> t -> unit;;
(* val to_string :  t -> string;; *)
(** the formula true *)
val tru : t;;
(** the formula false *)
val fals : t;;
