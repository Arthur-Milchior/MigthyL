let rec transform found next formula =
  match List.find_opt (fun (subformula, _) -> subformula = formula) with
  | Some (formula, index) -> (formula, index), found, next
  | None ->
     match formula with
     | Nnf.Nullary nul -> (formula, next), found, next+1
     | Nnf.Unary (op, phi) ->
        let phi, found, next = unique found phi in
        (Nnf.Unary (op, phi), next), found, next+1
     | Nnf.Binary (op, phi, psi) ->
        let phi, found, next = unique found phi in
        let psi, found, next = unique found psi in
        (Nnf.Binary (op, phi, psi), next), found, next+1
;;
let transform formula =
  let found, next, formula = transform [] 0 formula in
  formula
;;


