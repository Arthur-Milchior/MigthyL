let format_concat  ?empty ?empty_format ?(left=("@[":'a f)) ?(right=("@]":'a f))  ?(sep=(",@ ":'a f)) ?sep_fun format_elt fmt l=
  let l = match empty with
    | Some empty -> List.filter (fun elt -> elt <> empty) l
    | None -> l
  in
  match l with
  | [] ->
     (match empty_format, empty with
      | Some empty, _ -> fprintf fmt empty
      | None, Some empty ->  format_elt fmt empty
      | None, None -> ())
  | h:: t ->
     fprintf fmt left;
     format_elt  fmt h;
     List.iter (fun elt ->
         (match sep_fun with
          | None ->  fprintf fmt sep
          | Some sep_fun -> sep_fun fmt);
         fprintf fmt "@,";
         format_elt fmt elt) t;
     fprintf fmt right
;;
