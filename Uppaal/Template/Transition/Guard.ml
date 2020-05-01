open Utils;;

type t =
  string
;;

let format =
  pp_print_string
;;

type ts =
  t list
;;

let formats fmt guards =
  format_concat ~left: "@[<v 1><label kind=\"guard\">@," ~right:"@,@]</label>@," ~sep:" &amp;&amp;@ " format fmt guards
;;
