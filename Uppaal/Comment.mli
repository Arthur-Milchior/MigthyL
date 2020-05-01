(** A comment, to explain a part of the automaton. It's used in
   location, template and transition. It does not deal with comments in code.
*)
type t = string;;
val format :
  Format.formatter -> t -> unit
;;
