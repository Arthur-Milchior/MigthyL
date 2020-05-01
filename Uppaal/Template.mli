(**
   An UPPAAL template:
*)

type t =
  {
    name: string;
    transitions : Transition.t list ;
    declarations: C.t ;
    comment : Comment.t ;
  }

val format :
  Format.formatter -> t -> unit
;;
