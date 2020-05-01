
(** Represents that the variable `name` is given non-deterministically a value of type `type` *)
type t = Name.var * Type.t;;
val format : Format.formatter -> t -> unit;;

(** A list of non-deterministic selections*)
type ts = t list;;
val formats : Format.formatter -> ts -> unit;;
