type t = (Indexed.index list) array;;

let precompute subformulas =
  let subformulas = Subformula.subformulas subformulas in
  let length = List.length subformulas in
  let ar = Array.make length [] in
  List.iter (fun (formula, index) ->
      match formula with
      | Indexed.binary (_, (phi1, idx1), (phi2, idx2)) ->
         ar.(idx1) <- index :: ar.(idx1);
         ar.(idx2) <- index :: ar.(idx2);
    ) ();
  assert ar.(length-1) = [];
  ar.(length-1) = length;
  ar
;;


let getParentsIndex ar (_, idx) =
  ar.(idx)
;;

let getParentsFormula subformulas ar (_, idx) =
  List.map (fun idx -> Subformula.indexToSubformula subformulas idx) ar.(idx)
;;

let parentChildrenList parents subformulas =
  let subformulas = Subformula.subformulas subformulas in
  let pairsByChild = List.map (fun child ->
                         let parents = Parent.getParent parents child in
                         List.map (fun parent -> (parent, child)) parents
                       ) subformulas
  in
  List.concat pairsByChild
;;
