(**Associate a Boolean variable to each atomic proposition. It'll
   non-deterministically be set to a value when initiation a new
   cycle**)
let propositions formula =
  let atoms = Nnf.atomic_subformulas formulas in
  let vars = List.map Var.from_atom atoms in
  {MlType.var_typ: Type.Bool, var_vars = vars}
;;

(* let triggersPairs (formula, idx) parents subformulas=
 *   let l = Parent.parentChildrenList parents in
 *   let l = List.map (fun (parent, child) -> Var.from_triggerPair parent child) l in
 *   {MlType.var_typ: Type.Bool, var_vars = l}
 * ;;   *)

let triggersSolo (formula, idx) subformulas=
  let l = Subformula.subformulas subformulas in
  let l = List.map (fun (subformula, index) -> Var.from_triggerSolo index) l in
  {MlType.var_typ: Type.Bool, var_vars = l}
;;  
  
    
let accepting formula =
  let n = Indexed.nb_distinct_subformula formula in
  let l = ref [] in
  for idx = 0 to n do
    l := (Var.accept_subformula idx, MlType.True, None) :: !l
  done;
  {MlType.var_typ: Type.Bool, var_vars = !l};;
