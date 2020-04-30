(**Module for atomic properties. *)
type t ;;
(*create an atom from its name *)
val make: string -> t ;;
(**Print the atom, as it is *)
val format: Format.formatter -> t -> unit ;;
(**return the string given in entry. This should not be used, except to transform it immediatly into some other type *)
val to_string : t -> string ;;
module Set : (Set.S with type elt = t) ;;
