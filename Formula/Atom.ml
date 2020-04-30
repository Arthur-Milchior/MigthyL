(** Module for atomic properties.

    Fundamentally, those properties are string. However, it seems useful not use a separate type. In order to ensure that they are printed correctly when required *)

type t = string ;;
let make x = x ;;
let format = Format.pp_print_string ;;
let to_string x = x ;;

module Set = Utils.StringSet ;;
