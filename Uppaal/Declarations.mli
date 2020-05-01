(**Declaration in Templates and in NTA *)
type t =
  string
;;
val format :
  Format.formatter -> t -> unit
;;

type ts =
  string list
;;
val formats :
  ?comments:string -> Format.formatter -> t list -> unit
;;
