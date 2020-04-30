open Utils;;

(** Replacing syntactical sugar by its definition.  Do not consider
   negation *)
let rec eliminate = function
  | Input.Binary(op, formula, formula') ->
     let formula = eliminate formula and
         formula' = eliminate formula' in
     (match op with
      | Input.Implies ->
         (* `p -> q` becomes `(not p) or q` *)
         eliminate
           (Input.Binary(
                Input.Or,
                Input.Unary (Input.Not, formula),
                formula')
           )
      | Input.Iff ->
         (* `p <-> q` becomes `p->q and q -> p`. Applied recursively to remove the implication. *)
         eliminate(
             Input.Binary(
                 Input.And,
                 (Input.Binary (Input.Implies, formula, formula')),
                 (Input.Binary (Input.Implies, formula', formula))
               )
           )
      | Input.And -> NoUnary.Binary(NoUnary.And, formula,  formula')
      | Input.Or -> NoUnary.Binary(NoUnary.Or, formula,  formula')
      | Input.Until ivl -> NoUnary.Binary ((NoUnary.Until ivl), formula,  formula')
      | Input.Release ivl -> NoUnary.Binary ((NoUnary.Release ivl), formula,  formula'))
  | Input.Unary(op, formula) ->
     let formula = eliminate formula in
     (match op with
      | Input.Finally ivl ->
         (* `F_I p` becomes `⊤ U_I p` *)
         NoUnary.Binary (Until ivl, Input.Nullary Input.True, formula)
      | Input.Globally ivl ->
         (* `G_I p` becomes `⊥ R_I p` *)
         NoUnary.Binary (NoUnary.Release ivl, Input.Nullary Input.False, formula)
      | Input.SomeTimeInThePast ivl ->
         (* `-F_I p` becomes `⊤ S_I p` *)
         NoUnary.Binary (NoUnary.Since ivl, Input.Nullary Input.True, formula)
      | Input.GloballyInThePast ivl ->
         (* `-G_I p` becomes `⊥ B_I p` *)
         NoUnary.Binary (NoUnary.BackTo ivl, Input.Nullary Input.False, formula)
      | Input.Not ->
         NoUnary.Unary (NoUnary.Not, formula)
      | Input.Next ivl ->
         (* `N_I p` becomes `⊥ U_I p` *)
         NoUnary.Binary (NoUnary.Until ivl, NoUnary.Nullary NoUnary.False, formula)
      | Input.Brace ->
         (* Braces are useless for syntactic tree *)
         formula
     )
  | Input.Nullary (Input.True) ->
     NoUnary.Nullary(NoUnary.True)
  | Input.Nullary (Input.False) ->
     NoUnary.Nullary(NoUnary.False)
  | Input.Nullary (Input.Prop at) ->
     NoUnary.Nullary(NoUnary.Prop at)
;;

