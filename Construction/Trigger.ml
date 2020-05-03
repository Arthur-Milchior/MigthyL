let triggerredBySomeParent parents fmt ((_, index) as formula) =
  format_concat ~left:"function triggered_by_some_parent()@ @[{return@ @[("
    ~right:"@])@;//Whether some parent triggerred this formula@]}"
    ~sep:"@ &&@ "
    (fun fmt parent_index -> fprintf fmt "trigger_%d_%d" parent_index index) fmt (Parent.getParentsIndex parents index);;
;;

let immediatlyTrue fmt formula =
  fprintf fmt "function immediately_true()@ @[{return %a;@;//Whether the MITL holds simply du to immediate properties.@]}" Atemporal.format
;;
