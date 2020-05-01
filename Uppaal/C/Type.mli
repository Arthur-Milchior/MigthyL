(** The type of Uppal parameters *)
type t =
  | Bool
  | Int of int*int (* minimal, maximal bound*)
  | Clock
  | Array of t
  | Void
  | Struct of (name * t) list
  | TypeDefined of string
;;

val format:
  Format.formatter -> t -> unit
;;
