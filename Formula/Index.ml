(** 
@param found an assoc list of NNF formulas to their indexes
@param next the first nonnegative number such that no formula is asociated with it. Numbers between 0 and (next-1) included are assigned to formulas. 
@formula the formula to index
 *)
(* Subformulas are numbered before formulas. Either because the
   subformulas' number are already in `found` or because the recursion
   ensures that it is the case.  This way, the subformula has number
   smaller than formulas.*)
let rec transform found next formula =
  match List.find_opt (fun (subformula, _) -> subformula = formula) found with
  | Some (formula, index) -> (formula, index), found, next
  | None ->
     match formula with
     | Nnf.Nullary nul -> (formula, next), found, next+1
     | Nnf.Binary (op, phi, psi) ->
        let phi, found, next = unique found phi in
        let psi, found, next = unique found psi in
        (Nnf.Binary (op, phi, psi), next), found, next+1
;;

(** Replace index i by nbDistincSubformulas-i-1. This way main formula has index 0. *)
let inverse nbDistincSubformulas =
  let rec aux = fun
              | (Nnf.Nullary nul, index) -> (Nnf.Nullary null, nbDistincSubformulas - index - 1)
              | (Nnf.Binary (op, phi, psi), index) ->
                 (Nnf.Binary (op, aux phi, aux psi),
                  nbDistincSubformulas - index - 1)
  in aux
;;

(* Associate a number to each formula. This allow to count the number
   of distinct subformulas. Once this number is known, numbers are
   inversed, so that the path from formulas to subformulas follow an
   increasing order, with main formula starting at 0. *)
let transform formula =
  let found, next, formula = transform [] 0 formula in
  (inverse next formula, List.map (fun (formula, index) -> (formula, next - index -1)))
;;


