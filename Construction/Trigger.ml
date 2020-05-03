let trigger fmt (index_parent, index_child) =
  fprintf "trigger_%d_%d" index_child index_child
;;

let triggerredBySomeParent parents fmt ((_, index) as formula) =
  format_concat ~left:"function triggered_by_some_parent()@ @[{return@ @[("
    ~right:"@])@;//Whether some parent triggerred this formula@]}"
    ~sep:"@ &&@ "
    (fun fmt parent_index -> trigger fmt (parent_index, index)) fmt (Parent.getParentsIndex parents index);;
;;

let immediatlyTrue fmt formula =
  fprintf fmt "function immediately_true()@ @[{return %a;@;//Whether the MITL holds simply du to immediate properties.@]}" Atemporal.format
;;


let reallyTriggered fmt _ =
  fprint fmt "function really_triggered()@ @[{return@ (!immediately_true())@ &&@ triggered_by_some_parent();@;//Whether we should really trigger this subformula. E.g. a parent trigger it and its not immediately true.@]}"
;;
