open Utils;;

(** Function to negate the operators *)
let neg_nullary = function
  | Nnf.True -> Nnf.False
  | Nnf.False -> Nnf.True
  | Nnf.Prop s -> Nnf.Prop_neg s
  | Nnf.Prop_neg s-> Nnf.Prop s
;;

let neg_binary = function
  | Nnf.And -> Nnf.Or
  | Nnf.Or -> Nnf.And
  | Nnf.Until ivl -> Nnf.Release ivl
  | Nnf.Release ivl -> Nnf.Until ivl
  | Nnf.Since ivl -> Nnf.BackTo ivl
  | Nnf.BackTo ivl -> Nnf.Since ivl
;;


(** A formula equivalent to orig(or to Not orig if neg is True);
   without its syntactic sugar, in Negative Normal Form

neg -- whether to consider the negation of orig
orig -- a formula to put in normal form

**)
let rec translate_ neg orig =
  let formula=
    match orig with
    | Nullary nul ->
       let formula =
         match nul with
         | NoUnary.False -> Nnf.False
         | NoUnary.True -> Nnf.True
         | NoUnary.Prop prop -> (Nnf.Prop prop)
       in
       let formula = if neg then op_nullary formula else formula
       in Nnf.Nullary formula
    | Binary (operator, phi, psi) ->
       let operator=
         (match operator with
          | NoUnary.And -> Nnf.And
          | NoUnary.Or -> Nnf.Or
          | NoUnary.Until ivl -> Nnf.Until (ivl, new_available)
          | NoUnary.Release ivl -> Nnf.Release (ivl, new_available)
          | NoUnary.BackTo ivl -> Nnf.BackTo (ivl, new_available)
          | NoUnary.Since ivl -> Nnf.Since (ivl, new_available)
         )
       in
       let operator = if neg then neg_binary operator else operator
       in Nnf.Binary (operator, translate_ neg phi, translate_ neg psi)
;;
let translate = translate_ false;;
