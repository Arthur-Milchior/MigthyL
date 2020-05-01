(**Declaration in Templates and in NTA *)
open Utils;;
open Format;;

type t =
  string
;;
let format =
  pp_print_string
;;

type ts =
  string list
;;

let formats ?comments fmt declarations=
  fprintf fmt "@[<v 1><declaration>@,";
  format_concat  ~sep:"" format fmt declarations;
  (match comments with
  | Some  comments->  fprintf  fmt "/* %s */" comments
  | None -> ());
  fprintf fmt "@]@,</declaration>@,"
;;
