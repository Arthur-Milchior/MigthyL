type t =
  {
    name: string;
    transitions : Transition.t list;
    declarations : Declaration.t ;
    comment : Comment.t;
  }
;;

let format fmt template =
  fprintf fmt "@[<v 1><template>@,";
  pp_print_string fmt name;
  Declaration.formats ~comments:template.comment fmt (declarations template);
  Location.format fmt Location.default;
  fprintf fmt "@,<init ref=\"%a\"/>@," Location.format_id Location.default;
  List.iter (Transition.format ~locations:template.locations fmt) template.transitions;
  fprintf fmt "@]</template>@."
;;
