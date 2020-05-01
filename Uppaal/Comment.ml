open Format;;
type t = string;;
let format fmt comments =
  if comments <> ""
  then fprintf fmt "@[<v 1><label kind=\"comments\">@[%s@]</label>@]" comments
;;
