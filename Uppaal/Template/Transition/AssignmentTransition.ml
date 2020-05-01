open Utils;;
(**
   Assignement in transition
*)
type t =
  string
;;

let format =
  pp_print_string
;;


(**
    List of assigments. Using a list allow to do better formatting.
*)
type ts =
  t list
;;

let formats fmt assignments =
  format_concat ~left:"@[<v 1><label kind=\"assignment\">@," ~right:"@]@,</label>@,"  ~sep:"" format fmt assignments
;;
