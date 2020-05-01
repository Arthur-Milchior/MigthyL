(** Assignment during a transition. *)

(* the word "transition" is used in the file name in order to
   differentiate from the module Assignment *)
type t =
  string
;;

(** List of assigments. Using a list allow to do better formatting. *)
type ts =
  t list
;;

(** Assignments starting an automaton or a template*)
val format : Format.formatter -> t -> unit;;
