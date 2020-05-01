(** Type of predicate which should be satisfied for a transition to be taken. *)

type t =
  string
;;
(** Format as xml the guard *)
val format :
  Format.formatter -> t -> unit
;;

type ts =
  t list
;;
(** Format as xml a list of guards *)
val formats :
  Format.formatter -> t list -> unit
;;
