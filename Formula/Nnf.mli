open Utils;;
type nullary =
  | True
  | False
  | Prop of Atom.t
  | Prop_neg of Atom.t
;;

type binary=
  | And
  | Or
  | Until of Interval.t
  | Release of Interval.t
  | BackTo of Interval.t
  | Since of Interval.t
;;

type t =
  | Nullary of nullary
  | Binary of binary * t * t
;;

(** Formatting as a basic formula. Each temporal operator, apart from
    the root, are replaced by their proposition. *)
val format : Format.formatter -> t -> unit;;
