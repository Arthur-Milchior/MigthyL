(**
   Takes a list of element of type 'a.
   Format it as follows :
   Removes elements equal to empty, if it exists.
   If the list is empty, print empty_format, if it exists, otherwise print the empty element, otherwise do nothing

    If the list is non-empty, print left, each elements separated by sep, and then print right.
    By default, print as in list.
    Elements are printed using format_elt.
*)
val format_concat :
  ?empty:'a ->
  ?empty_format:(unit, Format.formatter, unit) format ->
  ?left:unit f ->
  ?right:unit f ->
  ?sep:unit f ->
  ?sep_fun:(Format.formatter -> unit) ->
  (Format.formatter -> 'a -> unit) -> Format.formatter -> 'a list -> unit;;
