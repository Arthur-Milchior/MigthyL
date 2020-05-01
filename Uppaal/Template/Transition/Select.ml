open Format;;
open Utils;;

type t =
  Name.var * Type.t
;;

type ts = t list ;;

let format fmt (var, typ)=
  fprintf fmt "%a:%a" Name.format_var var Type.format typ
;;

let formats fmt l=
  format_concat ~left:"@[<label kind=\"select\">@[<v 1>" ~right:"@]</label>@]" ~sep:",@ " format fmt l
;;
