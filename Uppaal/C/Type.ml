open Format;;
(** The type of Uppal parameters *)
type t =
  | Bool
  | Int of int*int
  | Clock
  | Array of t
  | Void
  | Struct of (name * t) list
  | TypeDefined of string
;;

let rec format fmt typ=
  (match typ with
   | Bool -> pp_print_string fmt "bool"
   | Clock -> pp_print_string fmt "clock"
   | Void -> pp_print_string fmt "void"
   | Int (a,b) -> fprintf fmt  "int[%d,%d]" a b
   | Array (t) -> fprintf fmt  "%a" format t
   | Struct l -> fprintf fmt  "struct %a" (format_concat ~left:"{@[" ~right:"@]}" ~sep:"; " format_pair) l
   | TypeDefined s -> pp_print_string fmt s
  )
  and
    format_pair fmt (name, typ) =
    fprintf fmt "%s: %a" name format typ
;;
