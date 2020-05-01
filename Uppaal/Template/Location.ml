open Format;;

type t = {
    id: Name.location;
    name: Name.t;
    comment: Comment.t;
  } ;;

let format fmt location =
  fprintf fmt "@[<v 1><location id=\"%a\">@," Name.format_location location.id;
  Name.format fmt location.name;
  Comment.format fmt location.comment;
  fprintf fmt "</location>@]"
;;

let default =
  {id = "q0"; name = "q0"; comment = ""}
;;

let format_id fmt location =
  pp_print_string fmt location.id
;;
