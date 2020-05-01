type t = {id: string;
          name: string;
          comment: Comment.t;
         } ;;

val format :
  Format.formatter -> t -> unit
;;

val format_id :
  Format.formatter -> t -> unit
;;

val default: t ;;
