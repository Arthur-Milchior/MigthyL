let trigger index =
  Printf.sprintf "trigger_%d" index
;;

(* let triggerredBySomeParent parents index =
 *   format_concat ~left:"function triggered_by_some_parent()@ @[{return@ @[("
 *     ~right:"@])@;//Whether some parent triggerred this formula@]}"
 *     ~sep:"@ &&@ "
 *     (fun fmt parent_index -> (trigger parent_index) fmt index) fmt (Parent.getParentsIndex parents index);;
 * ;; *)

let immediatlyTrue formula =
  Printf.sprintf "function immediately_true()@ @[{return %a;@;//Whether the MITL holds simply du to immediate properties.@]}" Atemporal.format (MakeImmediate.translate formula)
;;


let reallyTriggered index =
  Printf.sprintf "function really_triggered()@ @[{return@ (!%s)@ &&@ triggered_by_some_parent();@;//Whether we should really trigger this subformula. E.g. a parent trigger it and its not immediately true.@]}" (trigger index)
;;

let localDeclarations parents (formula, index) = [
    (* triggerredBySomeParent parents index; *)
    immediatlyTrue formula;
    reallyTriggered;
  ]
;;
